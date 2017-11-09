local class = require 'middleclass'
local moses = require 'moses'
local StructField = require 'stuart-sql.types.StructField'

local StructType = class('StructType')

function StructType:initialize(fields)
  self.fields = fields or {}
end

function StructType:__eq(other)
  return moses.same(self.fields, other.fields)
end

function StructType:__index(name)
  local field = moses.findWhere(self.fields, {name=name})
  if field == nil then
    error('Field "' .. name .. '" does not exist')
  end
  return field
end

function StructType:__tostring()
  local r = {}
  for _,field in ipairs(self.fields) do
    r[#r+1] = tostring(field)
  end
  return table.concat(r, ',')
end

--@InterfaceStability.Stable
--case class StructType(fields: Array[StructField]) extends DataType with Seq[StructField] {
--
--  /** No-arg constructor for kryo. */
--  def this() = this(Array.empty[StructField])
--
--  /** Returns all field names in an array. */
--  def fieldNames: Array[String] = fields.map(_.name)
--
--  private lazy val fieldNamesSet: Set[String] = fieldNames.toSet
--  private lazy val nameToField: Map[String, StructField] = fields.map(f => f.name -> f).toMap
--  private lazy val nameToIndex: Map[String, Int] = fieldNames.zipWithIndex.toMap
--
--  override def equals(that: Any): Boolean = {
--    that match {
--      case StructType(otherFields) =>
--        java.util.Arrays.equals(
--          fields.asInstanceOf[Array[AnyRef]], otherFields.asInstanceOf[Array[AnyRef]])
--      case _ => false
--    }
--  }
--
--  private lazy val _hashCode: Int = java.util.Arrays.hashCode(fields.asInstanceOf[Array[AnyRef]])
--  override def hashCode(): Int = _hashCode

function StructType:add(...)
  local fields = self.fields
  if #{...} >= 2 and type(select(1, ...)) == 'string' then
    local name = select(1, ...)
    local dataType = select(2, ...)
    local nullable = select(3, ...) or true
    local metadata = {}
    fields[#fields+1] = StructField:new(name, dataType, nullable, metadata)
  else
    local field = ...
    fields[#fields+1] = field
  end
  return StructType:new(fields)
end

--  /**
--   * Creates a new [[StructType]] by adding a new nullable field with no metadata.
--   *
--   * val struct = (new StructType)
--   *   .add("a", IntegerType)
--   *   .add("b", LongType)
--   *   .add("c", StringType)
--   */
--  def add(name: String, dataType: DataType): StructType = {
--    StructType(fields :+ StructField(name, dataType, nullable = true, Metadata.empty))
--  }
--
--  /**
--   * Creates a new [[StructType]] by adding a new field with no metadata.
--   *
--   * val struct = (new StructType)
--   *   .add("a", IntegerType, true)
--   *   .add("b", LongType, false)
--   *   .add("c", StringType, true)
--   */
--  def add(name: String, dataType: DataType, nullable: Boolean): StructType = {
--    StructType(fields :+ StructField(name, dataType, nullable, Metadata.empty))
--  }
--
--  /**
--   * Creates a new [[StructType]] by adding a new field and specifying metadata.
--   * {{{
--   * val struct = (new StructType)
--   *   .add("a", IntegerType, true, Metadata.empty)
--   *   .add("b", LongType, false, Metadata.empty)
--   *   .add("c", StringType, true, Metadata.empty)
--   * }}}
--   */
--  def add(
--      name: String,
--      dataType: DataType,
--      nullable: Boolean,
--      metadata: Metadata): StructType = {
--    StructType(fields :+ StructField(name, dataType, nullable, metadata))
--  }
--
--  /**
--   * Creates a new [[StructType]] by adding a new field and specifying metadata.
--   * {{{
--   * val struct = (new StructType)
--   *   .add("a", IntegerType, true, "comment1")
--   *   .add("b", LongType, false, "comment2")
--   *   .add("c", StringType, true, "comment3")
--   * }}}
--   */
--  def add(
--      name: String,
--      dataType: DataType,
--      nullable: Boolean,
--      comment: String): StructType = {
--    StructType(fields :+ StructField(name, dataType, nullable).withComment(comment))
--  }
--
--  /**
--   * Creates a new [[StructType]] by adding a new nullable field with no metadata where the
--   * dataType is specified as a String.
--   *
--   * {{{
--   * val struct = (new StructType)
--   *   .add("a", "int")
--   *   .add("b", "long")
--   *   .add("c", "string")
--   * }}}
--   */
--  def add(name: String, dataType: String): StructType = {
--    add(name, CatalystSqlParser.parseDataType(dataType), nullable = true, Metadata.empty)
--  }
--
--  /**
--   * Creates a new [[StructType]] by adding a new field with no metadata where the
--   * dataType is specified as a String.
--   *
--   * {{{
--   * val struct = (new StructType)
--   *   .add("a", "int", true)
--   *   .add("b", "long", false)
--   *   .add("c", "string", true)
--   * }}}
--   */
--  def add(name: String, dataType: String, nullable: Boolean): StructType = {
--    add(name, CatalystSqlParser.parseDataType(dataType), nullable, Metadata.empty)
--  }
--
--  /**
--   * Creates a new [[StructType]] by adding a new field and specifying metadata where the
--   * dataType is specified as a String.
--   * {{{
--   * val struct = (new StructType)
--   *   .add("a", "int", true, Metadata.empty)
--   *   .add("b", "long", false, Metadata.empty)
--   *   .add("c", "string", true, Metadata.empty)
--   * }}}
--   */
--  def add(
--      name: String,
--      dataType: String,
--      nullable: Boolean,
--      metadata: Metadata): StructType = {
--    add(name, CatalystSqlParser.parseDataType(dataType), nullable, metadata)
--  }
--
--  /**
--   * Creates a new [[StructType]] by adding a new field and specifying metadata where the
--   * dataType is specified as a String.
--   * {{{
--   * val struct = (new StructType)
--   *   .add("a", "int", true, "comment1")
--   *   .add("b", "long", false, "comment2")
--   *   .add("c", "string", true, "comment3")
--   * }}}
--   */
--  def add(
--      name: String,
--      dataType: String,
--      nullable: Boolean,
--      comment: String): StructType = {
--    add(name, CatalystSqlParser.parseDataType(dataType), nullable, comment)
--  }
--
--  /**
--   * Extracts the [[StructField]] with the given name.
--   *
--   * @throws IllegalArgumentException if a field with the given name does not exist
--   */
--  def apply(name: String): StructField = {
--    nameToField.getOrElse(name,
--      throw new IllegalArgumentException(s"""Field "$name" does not exist."""))
--  }
--
--  /**
--   * Returns a [[StructType]] containing [[StructField]]s of the given names, preserving the
--   * original order of fields.
--   *
--   * @throws IllegalArgumentException if a field cannot be found for any of the given names
--   */
--  def apply(names: Set[String]): StructType = {
--    val nonExistFields = names -- fieldNamesSet
--    if (nonExistFields.nonEmpty) {
--      throw new IllegalArgumentException(
--        s"Field ${nonExistFields.mkString(",")} does not exist.")
--    }
--    // Preserve the original order of fields.
--    StructType(fields.filter(f => names.contains(f.name)))
--  }

function StructType:fieldIndex(name)
  local index = moses.detect(self.fields, function(field) return field.name == name end)
  if index == nil then error('Field "' .. name .. '" does not exist') end
  return index - 1
end

--  protected[sql] def toAttributes: Seq[AttributeReference] =
--    map(f => AttributeReference(f.name, f.dataType, f.nullable, f.metadata)())
--
--  def treeString: String = {
--    val builder = new StringBuilder
--    builder.append("root\n")
--    val prefix = " |"
--    fields.foreach(field => field.buildFormattedString(prefix, builder))
--
--    builder.toString()
--  }
--
--  // scalastyle:off println
--  def printTreeString(): Unit = println(treeString)
--  // scalastyle:on println
--
--  private[sql] def buildFormattedString(prefix: String, builder: StringBuilder): Unit = {
--    fields.foreach(field => field.buildFormattedString(prefix, builder))
--  }
--
--  override private[sql] def jsonValue =
--    ("type" -> typeName) ~
--      ("fields" -> map(_.jsonValue))
--
--  override def apply(fieldIndex: Int): StructField = fields(fieldIndex)
--
--  override def length: Int = fields.length
--
--  override def iterator: Iterator[StructField] = fields.iterator
--
--  /**
--   * The default size of a value of the StructType is the total default sizes of all field types.
--   */
--  override def defaultSize: Int = fields.map(_.dataType.defaultSize).sum
--
--  override def simpleString: String = {
--    val fieldTypes = fields.view.map(field => s"${field.name}:${field.dataType.simpleString}")
--    Utils.truncatedString(fieldTypes, "struct<", ",", ">")
--  }
--
--  override def catalogString: String = {
--    // in catalogString, we should not truncate
--    val fieldTypes = fields.map(field => s"${field.name}:${field.dataType.catalogString}")
--    s"struct<${fieldTypes.mkString(",")}>"
--  }
--
--  override def sql: String = {
--    val fieldTypes = fields.map(f => s"${quoteIdentifier(f.name)}: ${f.dataType.sql}")
--    s"STRUCT<${fieldTypes.mkString(", ")}>"
--  }
--
--  private[sql] override def simpleString(maxNumberFields: Int): String = {
--    val builder = new StringBuilder
--    val fieldTypes = fields.take(maxNumberFields).map {
--      f => s"${f.name}: ${f.dataType.simpleString(maxNumberFields)}"
--    }
--    builder.append("struct<")
--    builder.append(fieldTypes.mkString(", "))
--    if (fields.length > 2) {
--      if (fields.length - fieldTypes.length == 1) {
--        builder.append(" ... 1 more field")
--      } else {
--        builder.append(" ... " + (fields.length - 2) + " more fields")
--      }
--    }
--    builder.append(">").toString()
--  }
--
--  /**
--   * Merges with another schema (`StructType`).  For a struct field A from `this` and a struct field
--   * B from `that`,
--   *
--   * 1. If A and B have the same name and data type, they are merged to a field C with the same name
--   *    and data type.  C is nullable if and only if either A or B is nullable.
--   * 2. If A doesn't exist in `that`, it's included in the result schema.
--   * 3. If B doesn't exist in `this`, it's also included in the result schema.
--   * 4. Otherwise, `this` and `that` are considered as conflicting schemas and an exception would be
--   *    thrown.
--   */
--  private[sql] def merge(that: StructType): StructType =
--    StructType.merge(this, that).asInstanceOf[StructType]
--
--  override private[spark] def asNullable: StructType = {
--    val newFields = fields.map {
--      case StructField(name, dataType, nullable, metadata) =>
--        StructField(name, dataType.asNullable, nullable = true, metadata)
--    }
--
--    StructType(newFields)
--  }
--
--  override private[spark] def existsRecursively(f: (DataType) => Boolean): Boolean = {
--    f(this) || fields.exists(field => field.dataType.existsRecursively(f))
--  }
--
--  @transient
--  private[sql] lazy val interpretedOrdering =
--    InterpretedOrdering.forSchema(this.fields.map(_.dataType))
--}
--
--/**
-- * @since 1.3.0
-- */
--@InterfaceStability.Stable
--object StructType extends AbstractDataType {
--
--  override private[sql] def defaultConcreteType: DataType = new StructType
--
--  override private[sql] def acceptsType(other: DataType): Boolean = {
--    other.isInstanceOf[StructType]
--  }
--
--  override private[sql] def simpleString: String = "struct"
--
--  private[sql] def fromString(raw: String): StructType = {
--    Try(DataType.fromJson(raw)).getOrElse(LegacyTypeStringParser.parse(raw)) match {
--      case t: StructType => t
--      case _ => throw new RuntimeException(s"Failed parsing StructType: $raw")
--    }
--  }
--
--  /**
--   * Creates StructType for a given DDL-formatted string, which is a comma separated list of field
--   * definitions, e.g., a INT, b STRING.
--   */
--  def fromDDL(ddl: String): StructType = CatalystSqlParser.parseTableSchema(ddl)
--
--  def apply(fields: Seq[StructField]): StructType = StructType(fields.toArray)
--
--  def apply(fields: java.util.List[StructField]): StructType = {
--    import scala.collection.JavaConverters._
--    StructType(fields.asScala)
--  }
--
--  private[sql] def fromAttributes(attributes: Seq[Attribute]): StructType =
--    StructType(attributes.map(a => StructField(a.name, a.dataType, a.nullable, a.metadata)))
--
--  private[sql] def removeMetadata(key: String, dt: DataType): DataType =
--    dt match {
--      case StructType(fields) =>
--        val newFields = fields.map { f =>
--          val mb = new MetadataBuilder()
--          f.copy(dataType = removeMetadata(key, f.dataType),
--            metadata = mb.withMetadata(f.metadata).remove(key).build())
--        }
--        StructType(newFields)
--      case _ => dt
--    }
--
--  private[sql] def merge(left: DataType, right: DataType): DataType =
--    (left, right) match {
--      case (ArrayType(leftElementType, leftContainsNull),
--      ArrayType(rightElementType, rightContainsNull)) =>
--        ArrayType(
--          merge(leftElementType, rightElementType),
--          leftContainsNull || rightContainsNull)
--
--      case (MapType(leftKeyType, leftValueType, leftContainsNull),
--      MapType(rightKeyType, rightValueType, rightContainsNull)) =>
--        MapType(
--          merge(leftKeyType, rightKeyType),
--          merge(leftValueType, rightValueType),
--          leftContainsNull || rightContainsNull)
--
--      case (StructType(leftFields), StructType(rightFields)) =>
--        val newFields = ArrayBuffer.empty[StructField]
--
--        val rightMapped = fieldsMap(rightFields)
--        leftFields.foreach {
--          case leftField @ StructField(leftName, leftType, leftNullable, _) =>
--            rightMapped.get(leftName)
--              .map { case rightField @ StructField(_, rightType, rightNullable, _) =>
--                leftField.copy(
--                  dataType = merge(leftType, rightType),
--                  nullable = leftNullable || rightNullable)
--              }
--              .orElse {
--                Some(leftField)
--              }
--              .foreach(newFields += _)
--        }
--
--        val leftMapped = fieldsMap(leftFields)
--        rightFields
--          .filterNot(f => leftMapped.get(f.name).nonEmpty)
--          .foreach { f =>
--            newFields += f
--          }
--
--        StructType(newFields)
--
--      case (DecimalType.Fixed(leftPrecision, leftScale),
--        DecimalType.Fixed(rightPrecision, rightScale)) =>
--        if ((leftPrecision == rightPrecision) && (leftScale == rightScale)) {
--          DecimalType(leftPrecision, leftScale)
--        } else if ((leftPrecision != rightPrecision) && (leftScale != rightScale)) {
--          throw new SparkException("Failed to merge decimal types with incompatible " +
--            s"precision $leftPrecision and $rightPrecision & scale $leftScale and $rightScale")
--        } else if (leftPrecision != rightPrecision) {
--          throw new SparkException("Failed to merge decimal types with incompatible " +
--            s"precision $leftPrecision and $rightPrecision")
--        } else {
--          throw new SparkException("Failed to merge decimal types with incompatible " +
--            s"scala $leftScale and $rightScale")
--        }
--
--      case (leftUdt: UserDefinedType[_], rightUdt: UserDefinedType[_])
--        if leftUdt.userClass == rightUdt.userClass => leftUdt
--
--      case (leftType, rightType) if leftType == rightType =>
--        leftType
--
--      case _ =>
--        throw new SparkException(s"Failed to merge incompatible data types $left and $right")
--    }
--
--  private[sql] def fieldsMap(fields: Array[StructField]): Map[String, StructField] = {
--    import scala.collection.breakOut
--    fields.map(s => (s.name, s))(breakOut)
--  }
--}

return StructType
