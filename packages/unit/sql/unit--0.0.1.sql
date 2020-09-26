\echo Use "CREATE EXTENSION unit" to load this file. \quit
CREATE SCHEMA units;

CREATE TABLE units.unit (
 	id serial PRIMARY KEY,
	name text,
	base bool DEFAULT ( (FALSE) ),
	value text,
	amount text,
	description text,
	type text,
	utf8 text,
	func text 
);

CREATE FUNCTION units.cast_str ( str text ) RETURNS json AS $EOFCODE$
DECLARE
  p text;
  p1 text;
  num text;
  p2 text;
  u units.unit;
BEGIN
  p = trim(regexp_replace(str, '\s+', ' ', 'g'));
  p1 = split_part(p, ' ', 1);
  num = replace(p1, ',', '')::numeric;
  p2 = split_part(p, ' ', 2);

  SELECT * FROM units.unit 
    WHERE name = p2
  INTO u;
 
  IF (FOUND) THEN
    RETURN json_build_object(
      'name', u.name,
      'type', u.type,
      'base', u.base,
      'amount', u.amount,
      'ival', u.value, -- TODO we need to simply combine ival and amount anyways...
      'value', num,
      'desc', u.description
    );
  END IF;

  RETURN json_build_object('type', p2, 'value', num);
END;
$EOFCODE$ LANGUAGE plpgsql STABLE;

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1, 'name', (FALSE), 'title', 'amount', 'desc', 'type', 'utf8', 'func');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2, 'kg', (FALSE), '!', NULL, 'Mass of the international prototype', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (3, 'kilogram', (FALSE), 'kg', NULL, NULL, 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (4, 's', (FALSE), '!', NULL, 'Duration of 9192631770 periods of the radiation', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (5, 'second', (FALSE), 's', NULL, 'corresponding to the transition between the two hyperfine', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (6, 'm', (FALSE), '!', NULL, 'Length of the path traveled by light in a vacuum', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (7, 'meter', (FALSE), 'm', NULL, 'during 1|299792458 seconds.  Originally meant to be', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (8, 'A', (FALSE), '!', NULL, 'The current which produces a force of 2e-7 N/m between two', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (9, 'ampere', (FALSE), 'A', NULL, 'infinitely long wires that are 1 meter apart', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (10, 'amp', (FALSE), 'ampere', NULL, NULL, 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (11, 'cd', (FALSE), '!', NULL, 'Luminous intensity in a given direction of a source which', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (12, 'candela', (FALSE), 'cd', NULL, 'emits monochromatic radiation at 540e12 Hz with radiant', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (13, 'mol', (FALSE), '!', NULL, 'The amount of substance of a system which contains as many', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (14, 'mole', (FALSE), 'mol', NULL, 'elementary entities as there are atoms in 0.012 kg of', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (15, 'K', (FALSE), '!', NULL, '1|273.16 of the thermodynamic temperature of the triple', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (16, 'kelvin', (FALSE), 'K', NULL, 'point of water', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (17, 'radian', (FALSE), '!dimensionless', NULL, 'The angle subtended at the center of a circle by', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (18, 'sr', (FALSE), '!dimensionless', NULL, 'Solid angle which cuts off an area of the surface', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (19, 'steradian', (FALSE), 'sr', NULL, 'of the sphere equal to that of a square with', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (20, 'B', (FALSE), '!', NULL, NULL, 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (21, 'byte', (FALSE), 'B', NULL, NULL, 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (22, 'bit', (FALSE), 'B', '1|8', 'Basic unit of information (entropy).  The entropy in bits', 'primitive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (23, 'yotta-', (FALSE), '1e24', NULL, 'Greek or Latin octo, "eight"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (24, 'zetta-', (FALSE), '1e21', NULL, 'Latin septem, "seven"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (25, 'exa-', (FALSE), '1e18', NULL, 'Greek hex, "six"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (26, 'peta-', (FALSE), '1e15', NULL, 'Greek pente, "five"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (27, 'tera-', (FALSE), '1e12', NULL, 'Greek teras, "monster"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (28, 'giga-', (FALSE), '1e9', NULL, 'Greek gigas, "giant"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (29, 'mega-', (FALSE), '1e6', NULL, 'Greek megas, "large"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (30, 'myria-', (FALSE), '1e4', NULL, 'Not an official SI prefix', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (31, 'kilo-', (FALSE), '1e3', NULL, 'Greek chilioi, "thousand"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (32, 'hecto-', (FALSE), '1e2', NULL, 'Greek hekaton, "hundred"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (33, 'deca-', (FALSE), '1e1', NULL, 'Greek deka, "ten"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (34, 'deka-', (FALSE), 'deca', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (35, 'deci-', (FALSE), '1e-1', NULL, 'Latin decimus, "tenth"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (36, 'centi-', (FALSE), '1e-2', NULL, 'Latin centum, "hundred"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (37, 'milli-', (FALSE), '1e-3', NULL, 'Latin mille, "thousand"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (38, 'micro-', (FALSE), '1e-6', NULL, 'Latin micro or Greek mikros, "small"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (39, 'nano-', (FALSE), '1e-9', NULL, 'Latin nanus or Greek nanos, "dwarf"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (40, 'pico-', (FALSE), '1e-12', NULL, 'Spanish pico, "a bit"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (41, 'femto-', (FALSE), '1e-15', NULL, 'Danish-Norwegian femten, "fifteen"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (42, 'atto-', (FALSE), '1e-18', NULL, 'Danish-Norwegian atten, "eighteen"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (43, 'zepto-', (FALSE), '1e-21', NULL, 'Latin septem, "seven"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (44, 'yocto-', (FALSE), '1e-24', NULL, 'Greek or Latin octo, "eight"', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (45, 'quarter-', (FALSE), '1|4', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (46, 'semi-', (FALSE), '0.5', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (47, 'demi-', (FALSE), '0.5', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (48, 'hemi-', (FALSE), '0.5', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (49, 'half-', (FALSE), '0.5', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (50, 'double-', (FALSE), '2', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (51, 'triple-', (FALSE), '3', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (52, 'treble-', (FALSE), '3', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (53, 'kibi-', (FALSE), '2^10', NULL, 'In response to the convention of illegally', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (54, 'mebi-', (FALSE), '2^20', NULL, 'and confusingly using metric prefixes for', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (55, 'gibi-', (FALSE), '2^30', NULL, 'powers of two, the International', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (56, 'tebi-', (FALSE), '2^40', NULL, 'Electrotechnical Commission aproved these', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (57, 'pebi-', (FALSE), '2^50', NULL, 'binary prefixes for use in 1998.  If you', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (58, 'exbi-', (FALSE), '2^60', NULL, 'want to refer to "megabytes" using the', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (59, 'zebi-', (FALSE), '2^70', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (60, 'yobi-', (FALSE), '2^80', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (61, 'Ki-', (FALSE), 'kibi', NULL, 'binary definition, use these prefixes.', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (62, 'Mi-', (FALSE), 'mebi', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (63, 'Gi-', (FALSE), 'gibi', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (64, 'Ti-', (FALSE), 'tebi', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (65, 'Pi-', (FALSE), 'pebi', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (66, 'Ei-', (FALSE), 'exbi', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (67, 'Zi-', (FALSE), 'zebi', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (68, 'Yi-', (FALSE), 'yobi', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (69, 'Y-', (FALSE), 'yotta', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (70, 'Z-', (FALSE), 'zetta', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (71, 'E-', (FALSE), 'exa', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (72, 'P-', (FALSE), 'peta', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (73, 'T-', (FALSE), 'tera', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (74, 'G-', (FALSE), 'giga', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (75, 'M-', (FALSE), 'mega', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (76, 'k-', (FALSE), 'kilo', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (77, 'h-', (FALSE), 'hecto', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (78, 'da-', (FALSE), 'deka', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (79, 'd-', (FALSE), 'deci', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (80, 'c-', (FALSE), 'centi', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (81, 'm-', (FALSE), 'milli', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (82, 'u-', (FALSE), 'micro', NULL, 'it should be a mu but u is easy to type', 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (83, 'mu-', (FALSE), 'micro', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (84, 'n-', (FALSE), 'nano', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (85, 'p-', (FALSE), 'pico', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (86, 'f-', (FALSE), 'femto', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (87, 'a-', (FALSE), 'atto', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (88, 'z-', (FALSE), 'zepto', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (89, 'y-', (FALSE), 'yocto', NULL, NULL, 'prefix', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (90, 'one', (FALSE), '1', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (91, 'two', (FALSE), '2', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (92, 'double', (FALSE), '2', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (93, 'couple', (FALSE), '2', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (94, 'three', (FALSE), '3', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (95, 'triple', (FALSE), '3', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (96, 'four', (FALSE), '4', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (97, 'quadruple', (FALSE), '4', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (98, 'five', (FALSE), '5', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (99, 'quintuple', (FALSE), '5', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (100, 'six', (FALSE), '6', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (101, 'seven', (FALSE), '7', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (102, 'eight', (FALSE), '8', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (103, 'nine', (FALSE), '9', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (104, 'ten', (FALSE), '10', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (105, 'eleven', (FALSE), '11', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (106, 'twelve', (FALSE), '12', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (107, 'thirteen', (FALSE), '13', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (108, 'fourteen', (FALSE), '14', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (109, 'fifteen', (FALSE), '15', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (110, 'sixteen', (FALSE), '16', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (111, 'seventeen', (FALSE), '17', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (112, 'eighteen', (FALSE), '18', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (113, 'nineteen', (FALSE), '19', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (114, 'twenty', (FALSE), '20', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (115, 'thirty', (FALSE), '30', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (116, 'forty', (FALSE), '40', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (117, 'fifty', (FALSE), '50', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (118, 'sixty', (FALSE), '60', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (119, 'seventy', (FALSE), '70', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (120, 'eighty', (FALSE), '80', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (121, 'ninety', (FALSE), '90', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (122, 'hundred', (FALSE), '100', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (123, 'thousand', (FALSE), '1000', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (124, 'million', (FALSE), '1e6', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (125, 'twoscore', (FALSE), 'score', 'two', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (126, 'threescore', (FALSE), 'score', 'three', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (127, 'fourscore', (FALSE), 'score', 'four', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (128, 'fivescore', (FALSE), 'score', 'five', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (129, 'sixscore', (FALSE), 'score', 'six', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (130, 'sevenscore', (FALSE), 'score', 'seven', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (131, 'eightscore', (FALSE), 'score', 'eight', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (132, 'ninescore', (FALSE), 'score', 'nine', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (133, 'tenscore', (FALSE), 'score', 'ten', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (134, 'twelvescore', (FALSE), 'score', 'twelve', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (135, 'shortbillion', (FALSE), '1e9', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (136, 'shorttrillion', (FALSE), '1e12', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (137, 'shortquadrillion', (FALSE), '1e15', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (138, 'shortquintillion', (FALSE), '1e18', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (139, 'shortsextillion', (FALSE), '1e21', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (140, 'shortseptillion', (FALSE), '1e24', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (141, 'shortoctillion', (FALSE), '1e27', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (142, 'shortnonillion', (FALSE), '1e30', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (143, 'shortnoventillion', (FALSE), 'shortnonillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (144, 'shortdecillion', (FALSE), '1e33', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (145, 'shortundecillion', (FALSE), '1e36', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (146, 'shortduodecillion', (FALSE), '1e39', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (147, 'shorttredecillion', (FALSE), '1e42', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (148, 'shortquattuordecillion', (FALSE), '1e45', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (149, 'shortquindecillion', (FALSE), '1e48', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (150, 'shortsexdecillion', (FALSE), '1e51', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (151, 'shortseptendecillion', (FALSE), '1e54', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (152, 'shortoctodecillion', (FALSE), '1e57', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (153, 'shortnovemdecillion', (FALSE), '1e60', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (154, 'shortvigintillion', (FALSE), '1e63', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (155, 'centillion', (FALSE), '1e303', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (156, 'googol', (FALSE), '1e100', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (157, 'longbillion', (FALSE), 'million^2', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (158, 'longtrillion', (FALSE), 'million^3', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (159, 'longquadrillion', (FALSE), 'million^4', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (160, 'longquintillion', (FALSE), 'million^5', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (161, 'longsextillion', (FALSE), 'million^6', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (162, 'longseptillion', (FALSE), 'million^7', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (163, 'longoctillion', (FALSE), 'million^8', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (164, 'longnonillion', (FALSE), 'million^9', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (165, 'longnoventillion', (FALSE), 'longnonillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (166, 'longdecillion', (FALSE), 'million^10', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (167, 'longundecillion', (FALSE), 'million^11', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (168, 'longduodecillion', (FALSE), 'million^12', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (169, 'longtredecillion', (FALSE), 'million^13', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (170, 'longquattuordecillion', (FALSE), 'million^14', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (171, 'longquindecillion', (FALSE), 'million^15', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (172, 'longsexdecillion', (FALSE), 'million^16', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (173, 'longseptdecillion', (FALSE), 'million^17', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (174, 'longoctodecillion', (FALSE), 'million^18', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (175, 'longnovemdecillion', (FALSE), 'million^19', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (176, 'longvigintillion', (FALSE), 'million^20', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (177, 'milliard', (FALSE), 'million', '1000', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (178, 'billiard', (FALSE), 'million^2', '1000', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (179, 'trilliard', (FALSE), 'million^3', '1000', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (180, 'quadrilliard', (FALSE), 'million^4', '1000', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (181, 'quintilliard', (FALSE), 'million^5', '1000', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (182, 'sextilliard', (FALSE), 'million^6', '1000', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (183, 'septilliard', (FALSE), 'million^7', '1000', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (184, 'octilliard', (FALSE), 'million^8', '1000', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (185, 'nonilliard', (FALSE), 'million^9', '1000', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (186, 'noventilliard', (FALSE), 'nonilliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (187, 'decilliard', (FALSE), 'million^10', '1000', NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (188, 'longmilliard', (FALSE), 'milliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (189, 'longbilliard', (FALSE), 'billiard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (190, 'longtrilliard', (FALSE), 'trilliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (191, 'longquadrilliard', (FALSE), 'quadrilliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (192, 'longquintilliard', (FALSE), 'quintilliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (193, 'longsextilliard', (FALSE), 'sextilliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (194, 'longseptilliard', (FALSE), 'septilliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (195, 'longoctilliard', (FALSE), 'octilliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (196, 'longnonilliard', (FALSE), 'nonilliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (197, 'longnoventilliard', (FALSE), 'noventilliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (198, 'longdecilliard', (FALSE), 'decilliard', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (199, 'billion', (FALSE), 'shortbillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (200, 'trillion', (FALSE), 'shorttrillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (201, 'quadrillion', (FALSE), 'shortquadrillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (202, 'quintillion', (FALSE), 'shortquintillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (203, 'sextillion', (FALSE), 'shortsextillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (204, 'septillion', (FALSE), 'shortseptillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (205, 'octillion', (FALSE), 'shortoctillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (206, 'nonillion', (FALSE), 'shortnonillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (207, 'noventillion', (FALSE), 'shortnoventillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (208, 'decillion', (FALSE), 'shortdecillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (209, 'undecillion', (FALSE), 'shortundecillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (210, 'duodecillion', (FALSE), 'shortduodecillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (211, 'tredecillion', (FALSE), 'shorttredecillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (212, 'quattuordecillion', (FALSE), 'shortquattuordecillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (213, 'quindecillion', (FALSE), 'shortquindecillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (214, 'sexdecillion', (FALSE), 'shortsexdecillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (215, 'septendecillion', (FALSE), 'shortseptendecillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (216, 'octodecillion', (FALSE), 'shortoctodecillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (217, 'novemdecillion', (FALSE), 'shortnovemdecillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (218, 'vigintillion', (FALSE), 'shortvigintillion', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (219, 'lakh', (FALSE), '1e5', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (220, 'crore', (FALSE), '1e7', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (221, 'arab', (FALSE), '1e9', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (222, 'kharab', (FALSE), '1e11', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (223, 'neel', (FALSE), '1e13', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (224, 'padm', (FALSE), '1e15', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (225, 'shankh', (FALSE), '1e17', NULL, NULL, 'numbers', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (226, 'US', (FALSE), 'm/ft', '1200|3937', 'These four values will convert', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (227, 'US-', (FALSE), 'US', NULL, 'international measures to', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (228, 'survey-', (FALSE), 'US', NULL, 'US Survey measures', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (229, 'geodetic-', (FALSE), 'US', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (230, 'int', (FALSE), 'ft/m', '3937|1200', 'Convert US Survey measures to', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (231, 'int-', (FALSE), 'int', NULL, 'international measures', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (232, 'yard', (FALSE), 'ft', '3', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (233, 'yd', (FALSE), 'yard', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (234, 'mile', (FALSE), 'ft', '5280', 'The mile was enlarged from 5000 ft', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (235, 'line', (FALSE), 'inch', '1|12', 'Also defined as ''.1 in'' or as ''1e-8 Wb''', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (236, 'rod', (FALSE), 'yard', '5.5', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (237, 'perch', (FALSE), 'rod', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (238, 'furlong', (FALSE), 'rod', '40', 'From "furrow long"', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (239, 'statutemile', (FALSE), 'mile', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (240, 'league', (FALSE), 'mile', '3', 'Intended to be an an hour''s walk', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (241, 'surveyorschain', (FALSE), 'surveyft', '66', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (242, 'surveychain', (FALSE), 'surveyorschain', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (243, 'surveyorspole', (FALSE), 'surveyorschain', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (244, 'surveyorslink', (FALSE), 'surveyorschain', '1|100', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (245, 'chain', (FALSE), 'ft', '66', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (246, 'link', (FALSE), 'chain', '1|100', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (247, 'ch', (FALSE), 'chain', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (248, 'USacre', (FALSE), 'surveychain^2', '10', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (249, 'intacre', (FALSE), 'chain^2', '10', 'Acre based on international ft', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (250, 'intacrefoot', (FALSE), 'foot', 'acre', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (251, 'USacrefoot', (FALSE), 'surveyfoot', 'USacre', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (252, 'acrefoot', (FALSE), 'intacrefoot', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (253, 'acre', (FALSE), 'intacre', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (254, 'section', (FALSE), 'mile^2', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (255, 'township', (FALSE), 'section', '36', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (256, 'homestead', (FALSE), 'acre', '160', 'Area of land granted by the 1862 Homestead', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (257, 'gunterschain', (FALSE), 'surveyorschain', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (258, 'engineerschain', (FALSE), 'ft', '100', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (259, 'engineerslink', (FALSE), 'engineerschain', '1|100', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (260, 'ramsdenschain', (FALSE), 'engineerschain', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (261, 'ramsdenslink', (FALSE), 'engineerslink', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (262, 'gurleychain', (FALSE), 'feet', '33', 'Andrew Ellicott chain is the', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (263, 'gurleylink', (FALSE), 'gurleychain', '1|50', 'same length', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (264, 'wingchain', (FALSE), 'feet', '66', 'Chain from 1664, introduced by', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (265, 'winglink', (FALSE), 'wingchain', '1|80', 'Vincent Wing, also found in a', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (266, 'troughtonyard', (FALSE), 'mm', '914.42190', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (267, 'bronzeyard11', (FALSE), 'mm', '914.39980', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (268, 'mendenhallyard', (FALSE), 'surveyyard', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (269, 'internationalyard', (FALSE), 'yard', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (270, 'fathom', (FALSE), 'ft', '6', 'Originally defined as the distance from', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (271, 'nauticalmile', (FALSE), 'm', '1852', 'Supposed to be one minute of latitude at', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (272, 'cable', (FALSE), 'nauticalmile', '1|10', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (273, 'intcable', (FALSE), 'cable', NULL, 'international cable', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (274, 'cablelength', (FALSE), 'cable', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (275, 'UScable', (FALSE), 'USfathom', '100', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (276, 'navycablelength', (FALSE), 'USft', '720', 'used for depth in water', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (277, 'marineleague', (FALSE), 'nauticalmile', '3', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (278, 'geographicalmile', (FALSE), 'brnauticalmile', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (279, 'click', (FALSE), 'km', NULL, 'US military slang', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (280, 'klick', (FALSE), 'click', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (281, 'pound', (FALSE), 'kg', '0.45359237', 'The one normally used', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (282, 'lb', (FALSE), 'pound', NULL, 'From the latin libra', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (283, 'grain', (FALSE), 'pound', '1|7000', 'The grain is the same in all three', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (284, 'ounce', (FALSE), 'pound', '1|16', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (285, 'oz', (FALSE), 'ounce', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (286, 'dram', (FALSE), 'ounce', '1|16', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (287, 'dr', (FALSE), 'dram', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (288, 'ushundredweight', (FALSE), 'pounds', '100', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (289, 'cwt', (FALSE), 'hundredweight', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (290, 'shorthundredweight', (FALSE), 'ushundredweight', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (291, 'uston', (FALSE), 'shortton', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (292, 'shortton', (FALSE), 'lb', '2000', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (293, 'quarterweight', (FALSE), 'uston', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (294, 'shortquarterweight', (FALSE), 'shortton', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (295, 'shortquarter', (FALSE), 'shortquarterweight', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (296, 'troypound', (FALSE), 'grain', '5760', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (297, 'troyounce', (FALSE), 'troypound', '1|12', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (298, 'ozt', (FALSE), 'troyounce', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (299, 'pennyweight', (FALSE), 'troyounce', '1|20', 'Abbreviated "d" in reference to a', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (300, 'dwt', (FALSE), 'pennyweight', NULL, 'Frankish coin called the "denier"', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (301, 'fineounce', (FALSE), 'troyounce', NULL, 'A troy ounce of 99.5% pure gold', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (302, 'metriccarat', (FALSE), 'gram', '0.2', 'Defined in 1907', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (303, 'metricgrain', (FALSE), 'mg', '50', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (304, 'carat', (FALSE), 'metriccarat', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (305, 'ct', (FALSE), 'carat', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (306, 'jewelerspoint', (FALSE), 'carat', '1|100', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (307, 'silversmithpoint', (FALSE), 'inch', '1|4000', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (308, 'momme', (FALSE), 'grams', '3.75', 'Traditional Japanese unit based', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (309, 'appound', (FALSE), 'troypound', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (310, 'apounce', (FALSE), 'troyounce', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (311, 'apdram', (FALSE), 'apounce', '1|8', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (312, 'apscruple', (FALSE), 'apdram', '1|3', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (313, 'usgallon', (FALSE), 'in^3', '231', 'US liquid measure is derived from', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (314, 'gallon', (FALSE), 'usgallon', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (315, 'gal', (FALSE), 'gallon', NULL, 'the British wine gallon of 1707.', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (316, 'quart', (FALSE), 'gallon', '1|4', 'See the "winegallon" entry below', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (317, 'pint', (FALSE), 'quart', '1|2', 'more historical information.', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (318, 'gill', (FALSE), 'pint', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (319, 'usquart', (FALSE), 'usgallon', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (320, 'uspint', (FALSE), 'usquart', '1|2', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (321, 'usgill', (FALSE), 'uspint', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (322, 'usfluidounce', (FALSE), 'uspint', '1|16', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (323, 'fluiddram', (FALSE), 'usfloz', '1|8', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (324, 'minimvolume', (FALSE), 'fluiddram', '1|60', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (325, 'qt', (FALSE), 'quart', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (326, 'pt', (FALSE), 'pint', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (327, 'floz', (FALSE), 'fluidounce', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (328, 'usfloz', (FALSE), 'usfluidounce', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (329, 'fldr', (FALSE), 'fluiddram', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (330, 'liquidbarrel', (FALSE), 'usgallon', '31.5', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (331, 'usbeerbarrel', (FALSE), 'beerkegs', '2', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (332, 'beerkeg', (FALSE), 'usgallon', '15.5', 'Various among brewers', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (333, 'ponykeg', (FALSE), 'beerkeg', '1|2', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (334, 'winekeg', (FALSE), 'usgallon', '12', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (335, 'petroleumbarrel', (FALSE), 'usgallon', '42', 'Originated in Pennsylvania oil', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (336, 'barrel', (FALSE), 'petroleumbarrel', NULL, 'fields, from the winetierce', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (337, 'bbl', (FALSE), 'barrel', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (338, 'ushogshead', (FALSE), 'liquidbarrel', '2', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (339, 'usfirkin', (FALSE), 'usgallon', '9', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (340, 'usbushel', (FALSE), 'in^3', '2150.42', 'Volume of 8 inch cylinder with 18.5', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (341, 'bu', (FALSE), 'bushel', NULL, 'inch diameter (rounded)', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (342, 'peck', (FALSE), 'bushel', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (343, 'uspeck', (FALSE), 'usbushel', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (344, 'brpeck', (FALSE), 'brbushel', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (345, 'pk', (FALSE), 'peck', NULL, NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (346, 'drygallon', (FALSE), 'uspeck', '1|2', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (347, 'dryquart', (FALSE), 'drygallon', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (348, 'drypint', (FALSE), 'dryquart', '1|2', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (349, 'drybarrel', (FALSE), 'in^3', '7056', 'Used in US for fruits, vegetables,', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (350, 'cranberrybarrel', (FALSE), 'in^3', '5826', 'US cranberry barrel', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (351, 'heapedbushel', (FALSE), 'usbushel', '1.278', 'The following explanation for this', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (352, 'wheatbushel', (FALSE), 'lb', '60', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (353, 'soybeanbushel', (FALSE), 'lb', '60', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (354, 'cornbushel', (FALSE), 'lb', '56', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (355, 'ryebushel', (FALSE), 'lb', '56', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (356, 'barleybushel', (FALSE), 'lb', '48', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (357, 'oatbushel', (FALSE), 'lb', '32', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (358, 'ricebushel', (FALSE), 'lb', '45', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (359, 'canada_oatbushel', (FALSE), 'lb', '34', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (360, 'ponyvolume', (FALSE), 'usfloz', '1', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (361, 'jigger', (FALSE), 'usfloz', '1.5', 'Can vary between 1 and 2 usfloz', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (362, 'shot', (FALSE), 'jigger', NULL, 'Sometimes 1 usfloz', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (363, 'eushot', (FALSE), 'ml', '25', 'EU standard spirits measure', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (364, 'fifth', (FALSE), 'usgallon', '1|5', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (365, 'winebottle', (FALSE), 'ml', '750', 'US industry standard, 1979', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (366, 'winesplit', (FALSE), 'winebottle', '1|4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (367, 'magnum', (FALSE), 'liter', '1.5', 'Standardized in 1979, but given', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (368, 'metrictenth', (FALSE), 'ml', '375', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (369, 'metricfifth', (FALSE), 'ml', '750', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (370, 'metricquart', (FALSE), 'liter', '1', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (371, 'reputedquart', (FALSE), 'brgallon', '1|6', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (372, 'reputedpint', (FALSE), 'reputedquart', '1|2', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (373, 'brwinebottle', (FALSE), 'reputedquart', NULL, 'Very close to 1|5 winegallon', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (374, 'split', (FALSE), 'ml', '200', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (375, 'jeroboam', (FALSE), 'magnum', '2', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (376, 'rehoboam', (FALSE), 'magnum', '3', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (377, 'methuselah', (FALSE), 'magnum', '4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (378, 'imperialbottle', (FALSE), 'magnum', '4', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (379, 'salmanazar', (FALSE), 'magnum', '6', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (380, 'balthazar', (FALSE), 'magnum', '8', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (381, 'nebuchadnezzar', (FALSE), 'magnum', '10', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (382, 'solomon', (FALSE), 'magnum', '12', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (383, 'melchior', (FALSE), 'magnum', '12', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (384, 'sovereign', (FALSE), 'magnum', '17.5', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (385, 'primat', (FALSE), 'magnum', '18', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (386, 'goliath', (FALSE), 'magnum', '18', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (387, 'melchizedek', (FALSE), 'magnum', '20', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (388, 'midas', (FALSE), 'magnum', '20', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (389, 'wineglass', (FALSE), 'mL', '150', 'the size of a "typical" serving', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (390, 'coffeeratio', (FALSE), 'g/L', '55', '± 10%', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (391, 'clarkdegree', (FALSE), 'grains/brgallon', NULL, 'Content by weigh of calcium carbonate', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (392, 'gpg', (FALSE), 'grains/usgallon', NULL, 'Divide by water''s density to convert to', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (393, 'shoeiron', (FALSE), 'inch', '1|48', 'Used to measure leather in soles', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (394, 'shoeounce', (FALSE), 'inch', '1|64', 'Used to measure non-sole shoe leather', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (395, 'shoesize_delta', (FALSE), 'inch', '1|3', 'USA shoe sizes differ by this amount', 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (396, 'shoe_men0', (FALSE), 'inch', '8.25', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (397, 'shoe_women0', (FALSE), 'inch', '(7+11|12)', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (398, 'shoe_boys0', (FALSE), 'inch', '(3+11|12)', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (399, 'shoe_girls0', (FALSE), 'inch', '(3+7|12)', NULL, 'us', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (400, 'europeshoesize', (FALSE), 'cm', '2|3', NULL, 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (401, 'buck', (FALSE), 'US$', NULL, NULL, 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (402, 'fin', (FALSE), 'US$', '5', NULL, 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (403, 'sawbuck', (FALSE), 'US$', '10', NULL, 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (404, 'usgrand', (FALSE), 'US$', '1000', NULL, 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (405, 'greenback', (FALSE), 'US$', NULL, NULL, 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (406, 'key', (FALSE), 'kg', NULL, 'usually of marijuana, 60''s', 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (407, 'lid', (FALSE), 'oz', '1', 'Another 60''s weed unit', 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (408, 'footballfield', (FALSE), 'usfootballfield', NULL, NULL, 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (409, 'usfootballfield', (FALSE), 'yards', '100', NULL, 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (410, 'canadafootballfield', (FALSE), 'yards', '110', 'And 65 yards wide', 'us', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (411, 'spherevol()', (FALSE), 'spherevolume', NULL, NULL, 'geometric', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (412, 'atomicmass', (FALSE), 'electronmass', NULL, NULL, 'fundamental', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (413, 'atomiccharge', (FALSE), 'e', NULL, NULL, 'fundamental', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (414, 'atomicaction', (FALSE), 'hbar', NULL, NULL, 'fundamental', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (415, 'atomiclength', (FALSE), 'bohrradius', NULL, NULL, 'fundamental', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (416, 'hartree', (FALSE), 'atomicenergy', NULL, NULL, 'fundamental', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (417, 'TIME', (FALSE), 'second', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (418, 'anomalisticyear', (FALSE), 'days', '365.2596', 'The time between successive', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (419, 'siderealyear', (FALSE), 'day', '365.256360417', 'The time for the earth to make', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (420, 'tropicalyear', (FALSE), 'day', '365.242198781', 'The time needed for the mean sun', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (421, 'eclipseyear', (FALSE), 'days', '346.62', 'The line of nodes is the', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (422, 'saros', (FALSE), 'synodicmonth', '223', 'The earth, moon and sun appear in', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (902, 'INDUCTANCE', (FALSE), 'henry', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (423, 'siderealday', (FALSE), 's', '86164.09054', 'The sidereal day is the interval', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (424, 'siderealhour', (FALSE), 'siderealday', '1|24', 'between two successive transits', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (425, 'siderealminute', (FALSE), 'siderealhour', '1|60', 'of a star over the meridian,', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (426, 'siderealsecond', (FALSE), 'siderealminute', '1|60', 'or the time required  for the', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (427, 'anomalisticmonth', (FALSE), 'day', '27.55454977', 'Time for the moon to travel from', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (428, 'nodicalmonth', (FALSE), 'day', '27.2122199', 'The nodes are the points where', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (429, 'draconicmonth', (FALSE), 'nodicalmonth', NULL, 'an orbit crosses the ecliptic.', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (430, 'draconiticmonth', (FALSE), 'nodicalmonth', NULL, 'This is the time required to', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (431, 'siderealmonth', (FALSE), 'day', '27.321661', 'Time required for the moon to', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (432, 'synodicmonth', (FALSE), 'lunarmonth', NULL, 'Full moons occur when the sun', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (433, 'lunation', (FALSE), 'synodicmonth', NULL, 'and moon are on opposite sides', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (434, 'lune', (FALSE), 'lunation', '1|30', 'of the earth.  Since the earth', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (435, 'lunour', (FALSE), 'lune', '1|24', 'moves around the sun, the moon', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (436, 'year', (FALSE), 'tropicalyear', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (437, 'yr', (FALSE), 'year', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (438, 'month', (FALSE), 'year', '1|12', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (439, 'mo', (FALSE), 'month', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (440, 'lustrum', (FALSE), 'years', '5', 'The Lustrum was a Roman', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (441, 'decade', (FALSE), 'years', '10', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (442, 'century', (FALSE), 'years', '100', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (443, 'millennium', (FALSE), 'years', '1000', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (444, 'millennia', (FALSE), 'millennium', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (445, 'solaryear', (FALSE), 'year', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (446, 'lunaryear', (FALSE), 'lunarmonth', '12', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (447, 'calendaryear', (FALSE), 'day', '365', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (448, 'commonyear', (FALSE), 'day', '365', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (449, 'leapyear', (FALSE), 'day', '366', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (450, 'julianyear', (FALSE), 'day', '365.25', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (451, 'gregorianyear', (FALSE), 'day', '365.2425', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (452, 'islamicyear', (FALSE), 'day', '354', 'A year of 12 lunar months. They', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (453, 'islamicleapyear', (FALSE), 'day', '355', 'began counting on July 16, AD 622', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (454, 'islamicmonth', (FALSE), 'islamicyear', '1|12', 'They have 29 day and 30 day months.', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (455, 'mercuryday', (FALSE), 'day', '58.6462', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (456, 'venusday', (FALSE), 'day', '243.01', 'retrograde', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (457, 'earthday', (FALSE), 'siderealday', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (458, 'marsday', (FALSE), 'day', '1.02595675', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (459, 'jupiterday', (FALSE), 'day', '0.41354', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (460, 'saturnday', (FALSE), 'day', '0.4375', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (461, 'uranusday', (FALSE), 'day', '0.65', 'retrograde', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (462, 'neptuneday', (FALSE), 'day', '0.768', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (463, 'plutoday', (FALSE), 'day', '6.3867', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (464, 'mercuryyear', (FALSE), 'julianyear', '0.2408467', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (465, 'venusyear', (FALSE), 'julianyear', '0.61519726', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (466, 'earthyear', (FALSE), 'siderealyear', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (467, 'marsyear', (FALSE), 'julianyear', '1.8808476', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (468, 'jupiteryear', (FALSE), 'julianyear', '11.862615', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (469, 'saturnyear', (FALSE), 'julianyear', '29.447498', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (470, 'uranusyear', (FALSE), 'julianyear', '84.016846', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (471, 'neptuneyear', (FALSE), 'julianyear', '164.79132', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (472, 'plutoyear', (FALSE), 'julianyear', '247.92065', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (473, 'earthflattening', (FALSE), '1|298.25642', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (474, 'earthradius_equatorial', (FALSE), 'm', '6378136.49', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (475, 'earthradius_polar', (FALSE), 'earthradius_equatorial', '(-earthflattening+1)', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (476, 'landarea', (FALSE), 'km^2', '148.847e6', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (477, 'oceanarea', (FALSE), 'km^2', '361.254e6', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (478, 'moonradius', (FALSE), 'km', '1738', 'mean value', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (479, 'sunradius', (FALSE), 'm', '6.96e8', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (480, 'gauss_k', (FALSE), '0.01720209895', NULL, 'This beast has dimensions of', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (481, 'astronomicalunit', (FALSE), 'm', '149597870700', 'IAU definition from 2012, exact', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (482, 'au', (FALSE), 'astronomicalunit', NULL, 'ephemeris for the above described', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (483, 'pc', (FALSE), 'parsec', NULL, 'from the sun to a point having', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (484, 'solarmass', (FALSE), 'kg', '1.9891e30', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (485, 'sunmass', (FALSE), 'solarmass', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (486, 'sundist', (FALSE), 'au', '1.0000010178', 'mean earth-sun distance', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (487, 'moondist', (FALSE), 'm', '3.844e8', 'mean earth-moon distance', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (488, 'sundist_near', (FALSE), 'm', '1.471e11', 'earth-sun distance at perihelion', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (489, 'sundist_far', (FALSE), 'm', '1.521e11', 'earth-sun distance at aphelion', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (490, 'moondist_min		3.564e8', (FALSE), 'm	', NULL, 'approximate least distance at', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (491, 'moondist_max		4.067e8', (FALSE), 'm	', NULL, 'approximate greatest distance at', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (492, 'moonearthmassratio', (FALSE), '0.012300034', NULL, 'uncertainty 3e-9', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (493, 'moonmass', (FALSE), 'earthmass', 'moonearthmassratio', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (494, 'oldmercurymass', (FALSE), 'kg', '0.33022e24', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (495, 'oldvenusmass', (FALSE), 'kg', '4.8690e24', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (496, 'oldmarsmass', (FALSE), 'kg', '0.64191e24', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (497, 'oldjupitermass', (FALSE), 'kg', '1898.8e24', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (498, 'oldsaturnmass', (FALSE), 'kg', '568.5e24', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (499, 'olduranusmass', (FALSE), 'kg', '86.625e24', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (500, 'oldneptunemass', (FALSE), 'kg', '102.78e24', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (501, 'oldplutomass', (FALSE), 'kg', '0.015e24', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (502, 'mercuryradius', (FALSE), 'km', '2440', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (503, 'venusradius', (FALSE), 'km', '6051.84', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (504, 'earthradius', (FALSE), 'km', '6371.01', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (505, 'marsradius', (FALSE), 'km', '3389.92', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (506, 'jupiterradius', (FALSE), 'km', '69911', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (507, 'saturnradius', (FALSE), 'km', '58232', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (508, 'uranusradius', (FALSE), 'km', '25362', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (509, 'neptuneradius', (FALSE), 'km', '24624', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (510, 'plutoradius', (FALSE), 'km', '1151', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (903, 'B_FIELD', (FALSE), 'tesla', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (511, 'moongravity', (FALSE), 'm/s^2', '1.62', NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (512, 'hubble', (FALSE), 'km/s/Mpc', '70', 'approximate', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (513, 'H0', (FALSE), 'hubble', NULL, NULL, 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (514, 'moonhp', (FALSE), 'lunarparallax', NULL, 'horizontal parallax', 'astronomical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (515, 'moonsd	asin(moonradius', (FALSE), 'moondist)', '/', 'Moon angular semidiameter at mean distance', 'astronomical', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (516, 'sunsd	asin(sunradius', (FALSE), 'sundist)', '/', 'Sun angular semidiameter at mean distance', 'astronomical', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (517, 'thermalcoulomb', (FALSE), 'J/K', NULL, 'entropy', 'thermal', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (518, 'thermalampere', (FALSE), 'W/K', NULL, 'entropy flow', 'thermal', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (519, 'thermalfarad', (FALSE), 'J/K^2', NULL, NULL, 'thermal', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (520, 'thermalohm', (FALSE), 'K^2/W', NULL, 'thermal resistance', 'thermal', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (521, 'fourier', (FALSE), 'thermalohm', NULL, NULL, 'thermal', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (522, 'thermalhenry', (FALSE), 'K^2/W^2', 'J', 'thermal inductance', 'thermal', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (523, 'thermalvolt', (FALSE), 'K', NULL, 'thermal potential difference', 'thermal', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (524, 'UK', (FALSE), 'UKlength_SJJ', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (525, 'UK-', (FALSE), 'UK', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (526, 'british-', (FALSE), 'UK', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (527, 'brnauticalmile', (FALSE), 'ft', '6080', 'Used until 1970 when the UK', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (528, 'brcable', (FALSE), 'brnauticalmile', '1|10', 'nautical mile.', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (529, 'admiraltymile', (FALSE), 'brnauticalmile', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (530, 'admiraltyknot', (FALSE), 'brknot', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (531, 'admiraltycable', (FALSE), 'brcable', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (532, 'seamile', (FALSE), 'ft', '6000', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (533, 'shackle', (FALSE), 'fathoms', '15', 'Adopted 1949 by British navy', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (534, 'clove', (FALSE), 'lb', '7', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (535, 'stone', (FALSE), 'lb', '14', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (536, 'tod', (FALSE), 'lb', '28', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (537, 'brquarterweight', (FALSE), 'brhundredweight', '1|4', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (538, 'brhundredweight', (FALSE), 'stone', '8', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (539, 'longhundredweight', (FALSE), 'brhundredweight', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (540, 'longton', (FALSE), 'brhundredweight', '20', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (541, 'brton', (FALSE), 'longton', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (542, 'brminim', (FALSE), 'brdram', '1|60', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (543, 'brscruple', (FALSE), 'brdram', '1|3', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (544, 'fluidscruple', (FALSE), 'brscruple', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (545, 'brdram', (FALSE), 'brfloz', '1|8', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (546, 'brfluidounce', (FALSE), 'brpint', '1|20', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (547, 'brfloz', (FALSE), 'brfluidounce', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (548, 'brgill', (FALSE), 'brpint', '1|4', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (549, 'brpint', (FALSE), 'brquart', '1|2', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (550, 'brquart', (FALSE), 'brgallon', '1|4', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (551, 'brgallon', (FALSE), 'l', '4.54609', 'The British Imperial gallon was', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (552, 'brbarrel', (FALSE), 'brgallon', '36', 'Used for beer', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (553, 'brbushel', (FALSE), 'brgallon', '8', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (554, 'brheapedbushel', (FALSE), 'brbushel', '1.278', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (555, 'brquarter', (FALSE), 'brbushel', '8', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (556, 'brchaldron', (FALSE), 'brbushel', '36', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (557, 'bag', (FALSE), 'brbushel', '4', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (558, 'bucket', (FALSE), 'brgallon', '4', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (559, 'kilderkin', (FALSE), 'brfirkin', '2', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (560, 'last', (FALSE), 'brbushel', '40', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (561, 'noggin', (FALSE), 'brgill', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (562, 'pottle', (FALSE), 'brgallon', '0.5', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (563, 'pin', (FALSE), 'brgallon', '4.5', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (564, 'puncheon', (FALSE), 'brgallon', '72', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (565, 'seam', (FALSE), 'brbushel', '8', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (566, 'coomb', (FALSE), 'brbushel', '4', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (567, 'boll', (FALSE), 'brbushel', '6', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (568, 'firlot', (FALSE), 'boll', '1|4', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (569, 'brfirkin', (FALSE), 'brgallon', '9', 'Used for ale and beer', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (570, 'cran', (FALSE), 'brgallon', '37.5', 'measures herring, about 750 fish', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (571, 'brwinehogshead', (FALSE), 'brgallon', '52.5', 'This value is approximately equal', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (572, 'brhogshead', (FALSE), 'brwinehogshead', NULL, 'to the old wine hogshead of 63', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (573, 'brbeerhogshead', (FALSE), 'brgallon', '54', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (574, 'brbeerbutt', (FALSE), 'brbeerhogshead', '2', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (575, 'registerton', (FALSE), 'ft^3', '100', 'Used for internal capacity of ships', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (576, 'shippington', (FALSE), 'ft^3', '40', 'Used for ship''s cargo freight or timber', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (577, 'brshippington', (FALSE), 'ft^3', '42', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (578, 'freightton', (FALSE), 'shippington', NULL, 'Both register ton and shipping ton derive', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (579, 'displacementton', (FALSE), 'ft^3', '35', 'Approximate volume of a longton weight of', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (580, 'waterton', (FALSE), 'brgallon', '224', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (581, 'strike', (FALSE), 'l', '70.5', '16th century unit, sometimes', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (582, 'amber', (FALSE), 'brbushel', '4', 'Used for dry and liquid capacity [18]', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (583, 'imperialminim', (FALSE), 'brminim', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (584, 'imperialscruple', (FALSE), 'brscruple', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (585, 'imperialdram', (FALSE), 'brdram', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (586, 'imperialfluidounce', (FALSE), 'brfluidounce', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (587, 'imperialfloz', (FALSE), 'brfloz', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (588, 'imperialgill', (FALSE), 'brgill', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (589, 'imperialpint', (FALSE), 'brpint', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (590, 'imperialquart', (FALSE), 'brquart', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (591, 'imperialgallon', (FALSE), 'brgallon', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (592, 'imperialbarrel', (FALSE), 'brbarrel', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (593, 'imperialbushel', (FALSE), 'brbushel', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (594, 'imperialheapedbushel', (FALSE), 'brheapedbushel', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (595, 'imperialquarter', (FALSE), 'brquarter', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (596, 'imperialchaldron', (FALSE), 'brchaldron', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (597, 'imperialwinehogshead', (FALSE), 'brwinehogshead', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (598, 'imperialhogshead', (FALSE), 'brhogshead', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (599, 'imperialbeerhogshead', (FALSE), 'brbeerhogshead', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (600, 'imperialbeerbutt', (FALSE), 'brbeerbutt', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (601, 'imperialfirkin', (FALSE), 'brfirkin', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (602, 'barleycorn', (FALSE), 'UKinch', '1|3', 'Given in Realm of Measure as the', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (603, 'nail', (FALSE), 'UKyard', '1|16', 'Originally the width of the thumbnail,', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (604, 'pole', (FALSE), 'UKft', '16.5', 'This was 15 Saxon feet, the Saxon', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (605, 'rope', (FALSE), 'UKft', '20', 'foot (aka northern foot) being longer', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (606, 'englishell', (FALSE), 'UKinch', '45', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (607, 'flemishell', (FALSE), 'UKinch', '27', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (608, 'ell', (FALSE), 'englishell', NULL, 'supposed to be measure from elbow to', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (609, 'span', (FALSE), 'UKinch', '9', 'supposed to be distance from thumb', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (610, 'goad', (FALSE), 'UKft', '4.5', 'used for cloth, possibly named after the', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (611, 'hide', (FALSE), 'acre', '120', 'English unit of land area dating to the 7th', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (612, 'virgate', (FALSE), 'hide', '1|4', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (613, 'nook', (FALSE), 'virgate', '1|2', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (614, 'rood', (FALSE), 'rod', 'furlong', 'Area of a strip a rod by a furlong', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (615, 'englishcarat', (FALSE), 'troyounce/151.5', NULL, 'Originally intended to be 4 grain', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (616, 'mancus', (FALSE), 'oz', '2', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (617, 'mast', (FALSE), 'lb', '2.5', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (618, 'nailkeg', (FALSE), 'lbs', '100', NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (619, 'basebox', (FALSE), 'in^2', '31360', 'Used in metal plating', 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (620, 'metre', (FALSE), 'meter', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (621, 'gramme', (FALSE), 'gram', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (622, 'litre', (FALSE), 'liter', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (623, 'dioptre', (FALSE), 'diopter', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (624, 'aluminium', (FALSE), 'aluminum', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (625, 'sulphur', (FALSE), 'sulfur', NULL, NULL, 'british', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (626, 'LUMINOUS_INTENSITY', (FALSE), 'candela', NULL, NULL, 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (627, 'LUMINOUS_FLUX', (FALSE), 'lumen', NULL, NULL, 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (628, 'LUMINOUS_ENERGY', (FALSE), 'talbot', NULL, NULL, 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (629, 'ILLUMINANCE', (FALSE), 'lux', NULL, NULL, 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (630, 'EXITANCE', (FALSE), 'lux', NULL, NULL, 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (631, 'candle', (FALSE), 'candela', '1.02', 'Standard unit for luminous intensity', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (632, 'hefnerunit', (FALSE), 'candle', '0.9', 'in use before candela', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (633, 'hefnercandle', (FALSE), 'hefnerunit', NULL, NULL, 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (634, 'violle', (FALSE), 'cd', '20.17', 'luminous intensity of 1 cm^2 of', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (635, 'lumen', (FALSE), 'sr', 'cd', 'Luminous flux (luminous energy per', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (636, 'lm', (FALSE), 'lumen', NULL, 'time unit)', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (637, 'talbot', (FALSE), 's', 'lumen', 'Luminous energy', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (638, 'lumberg', (FALSE), 'talbot', NULL, 'References give these values for', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (639, 'lumerg', (FALSE), 'talbot', NULL, 'lumerg and lumberg both.  Note that', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (640, 'lux', (FALSE), 'lm/m^2', NULL, 'Illuminance or exitance (luminous', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (641, 'lx', (FALSE), 'lux', NULL, 'flux incident on or coming from', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (642, 'ph', (FALSE), 'phot', NULL, NULL, 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (643, 'footcandle', (FALSE), 'lumen/ft^2', NULL, 'Illuminance from a 1 candela source', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (644, 'metercandle', (FALSE), 'lumen/m^2', NULL, 'Illuminance from a 1 candela source', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (645, 'mcs', (FALSE), 's', 'metercandle', 'luminous energy per area, used to', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (646, 'nox', (FALSE), 'lux', '1e-3', 'These two units were proposed for', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (647, 'skot', (FALSE), 'apostilb', '1e-3', 'measurements relating to dark adapted', 'photometric', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (648, 'sqrt_cm', (FALSE), '!', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (649, 'sqrt_centimeter', (FALSE), 'sqrt_cm', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (650, '+m', (FALSE), 'sqrt_cm^2', '100', NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (651, 'sqrt_g', (FALSE), '!', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (652, 'sqrt_gram', (FALSE), 'sqrt_g', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (653, '+kg', (FALSE), 'sqrt_g^2', 'kilo', NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (654, 'esu', (FALSE), 'statcoulomb', NULL, 'of 1 statC separated by 1 cm', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (655, 'statcoul', (FALSE), 'statcoulomb', NULL, 'exert a force of 1 dyne', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (656, 'statC', (FALSE), 'statcoulomb', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (657, 'stC', (FALSE), 'statcoulomb', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (658, 'franklin', (FALSE), 'statcoulomb', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (659, 'Fr', (FALSE), 'franklin', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (660, 'statamp', (FALSE), 'statampere', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (661, 'statA', (FALSE), 'statampere', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (662, 'stA', (FALSE), 'statampere', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (663, 'statV', (FALSE), 'statvolt', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (664, 'stV', (FALSE), 'statvolt', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (665, 'statF', (FALSE), 'statfarad', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (666, 'stF', (FALSE), 'statfarad', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (667, 'cmcapacitance', (FALSE), 'statfarad', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (668, 'statH', (FALSE), 'stathenry', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (669, 'stH', (FALSE), 'stathenry', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (670, 'stohm', (FALSE), 'statohm', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (671, 'statmho', (FALSE), '/statohm', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (672, 'stmho', (FALSE), 'statmho', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (673, 'statweber', (FALSE), 'sec', 'statvolt', NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (674, 'statWb', (FALSE), 'statweber', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (675, 'stWb', (FALSE), 'statweber', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (676, 'stattesla', (FALSE), 'statWb/cm^2', NULL, 'Defined by analogy with SI; rarely', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (677, 'statT', (FALSE), 'stattesla', NULL, 'if ever used', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (678, 'stT', (FALSE), 'stattesla', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (679, 'helmholtz', (FALSE), 'debye/angstrom^2', NULL, 'Dipole moment per area', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (680, 'jar', (FALSE), 'statfarad', '1000', 'approx capacitance of Leyden jar', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (681, 'abampere', (FALSE), 'A', '10', 'Current which produces a force of', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (682, 'abamp', (FALSE), 'abampere', NULL, '2 dyne/cm between two infinitely', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (683, 'abA', (FALSE), 'abampere', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (684, 'biot', (FALSE), 'abampere', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (685, 'Bi', (FALSE), 'biot', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (686, 'abcoulomb', (FALSE), 'sec', 'abamp', NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (687, 'abcoul', (FALSE), 'abcoulomb', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (688, 'abC', (FALSE), 'abcoulomb', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (689, 'abF', (FALSE), 'abfarad', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (690, 'abH', (FALSE), 'abhenry', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (691, 'abV', (FALSE), 'abvolt', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (692, 'abmho', (FALSE), '/abohm', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (693, 'Gs', (FALSE), 'gauss', NULL, 'carrying a current of 1 abampere', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (694, 'maxwell', (FALSE), 'cm^2', 'gauss', 'Also called the "line"', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (695, 'Mx', (FALSE), 'maxwell', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (696, 'Oe', (FALSE), 'oersted', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (697, 'Gb', (FALSE), 'gilbert', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (698, 'Gi', (FALSE), 'gilbert', NULL, NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (699, 'emu', (FALSE), 'erg/gauss', NULL, '"electro-magnetic unit", a measure of', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (700, 'intampere', (FALSE), 'A', '0.999835', 'Defined as the current which in one', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (701, 'intamp', (FALSE), 'intampere', NULL, 'second deposits .001118 gram of', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (702, 'intfarad', (FALSE), 'F', '0.999505', NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (703, 'intvolt', (FALSE), 'V', '1.00033', NULL, 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (704, 'intohm', (FALSE), 'ohm', '1.000495', 'Defined as the resistance of a', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (705, 'daniell', (FALSE), 'V', '1.042', 'Meant to be electromotive force of a', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (706, 'faraday_phys', (FALSE), 'C', '96521.9', 'liberate one gram equivalent of any', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (707, 'faraday_chem', (FALSE), 'C', '96495.7', 'element.  (The chemical and physical', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (708, 'kappline', (FALSE), 'maxwell', '6000', 'Named by and for Gisbert Kapp', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (709, 'siemensunit', (FALSE), 'ohm', '0.9534', 'Resistance of a meter long column of', 'electrostatic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (710, 'geometricpace', (FALSE), 'ft', '5', 'distance between points where the same', 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (711, 'pace', (FALSE), 'ft', '2.5', 'distance between points where alternate', 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (712, 'USmilitarypace', (FALSE), 'in', '30', 'United States official military pace', 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (713, 'USdoubletimepace', (FALSE), 'in', '36', 'United States official doubletime pace', 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (714, 'fingerbreadth', (FALSE), 'in', '7|8', 'The finger is defined as either the width', 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (715, 'fingerlength', (FALSE), 'in', '4.5', 'or length of the finger', 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (716, 'finger', (FALSE), 'fingerbreadth', NULL, NULL, 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (717, 'palmwidth', (FALSE), 'hand', NULL, 'The palm is a unit defined as either the width', 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (718, 'palmlength', (FALSE), 'in', '8', 'or the length of the hand', 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (719, 'hand', (FALSE), 'inch', '4', 'width of hand', 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (720, 'shaftment', (FALSE), 'inch', '6', 'Distance from tip of outstretched thumb to the', 'human', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (721, 'IACS', (FALSE), 'copperconductivity', NULL, 'a 1 mm^2 cross section', 'conductivity', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (722, 'copperdensity', (FALSE), 'g/cm^3', '8.89', 'The "ounce" measures the', 'conductivity', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (723, 'ozcu', (FALSE), 'ouncecopper', NULL, 'in circuitboard fabrication', 'conductivity', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (724, 'pi', (FALSE), '3.14159265358979323846', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (725, 'π', (FALSE), 'pi', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (726, 'c', (FALSE), 'm/s', '2.99792458e8', 'speed of light in vacuum (exact)', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (727, 'light', (FALSE), 'c', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (728, 'epsilon0', (FALSE), 'c^2', '1/mu0', 'permittivity of vacuum (exact)', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (729, 'energy', (FALSE), 'c^2', NULL, 'convert mass to energy', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (730, 'e', (FALSE), 'C', '1.6021766208e-19', 'electron charge', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (731, 'eV', (FALSE), 'V', 'e', 'Energy acquired by a particle with charge e', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (732, 'electronvolt', (FALSE), 'eV', NULL, 'when it is accelerated through 1 V', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (733, 'spin', (FALSE), 'hbar', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (734, 'atomicmassunit', (FALSE), 'kg', '1.660539040e-27', 'atomic mass unit (defined to be', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (735, 'u', (FALSE), 'atomicmassunit', NULL, '1|12 of the mass of carbon 12)', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (736, 'amu', (FALSE), 'atomicmassunit', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (737, 'amu_chem', (FALSE), 'kg', '1.66026e-27', '1|16 of the weighted average mass of', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (738, 'amu_phys', (FALSE), 'kg', '1.65981e-27', '1|16 of the mass of a neutral', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (739, 'dalton', (FALSE), 'u', NULL, 'Maybe this should be amu_chem?', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (740, 'avogadro', (FALSE), 'mol', 'grams/amu', 'size of a mole', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (741, 'N_A', (FALSE), 'avogadro', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (742, 'gasconstant', (FALSE), 'N_A', 'k', 'molar gas constant', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (743, 'R', (FALSE), 'gasconstant', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (744, 'boltzmann', (FALSE), 'J/K', '1.38064852e-23', 'Boltzmann constant', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (745, 'k', (FALSE), 'boltzmann', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (746, 'kboltzmann', (FALSE), 'boltzmann', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (747, 'sigma', (FALSE), 'stefanboltzmann', NULL, 'blackbody at temperature T is', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (748, 'K_J90', (FALSE), 'GHz/V', '483597.9', 'Direct measurement of the volt is difficult.  Until', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (749, 'K_J', (FALSE), 'GHz/V', '483597.8525', 'recently, laboratories kept Weston cadmium cells as', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (750, 'R_K90', (FALSE), 'ohm', '25812.807', 'Measurement of the ohm also presents difficulties.', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (751, 'R_K', (FALSE), 'ohm', '25812.8074555', 'The old approach involved maintaining resistances', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (752, 'gravity', (FALSE), 'm/s^2', '9.80665', 'std acceleration of gravity (exact)', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (753, 'force', (FALSE), 'gravity', NULL, 'use to turn masses into forces', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (754, 'atm', (FALSE), 'Pa', '101325', 'Standard atmospheric pressure', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (755, 'atmosphere', (FALSE), 'atm', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (756, 'water', (FALSE), 'force/cm^3', 'gram', 'Standard weight of water (exact)', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (757, 'H2O', (FALSE), 'water', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (758, 'wc', (FALSE), 'water', NULL, 'water column', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (759, 'mach', (FALSE), 'm/s', '331.46', 'speed of sound in dry air at STP', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (760, 'standardtemp', (FALSE), 'K', '273.15', 'standard temperature', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (761, 'stdtemp', (FALSE), 'standardtemp', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (762, 'normaltemp', (FALSE), 'tempF(70)', NULL, 'for gas density, from NIST', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (763, 'normtemp', (FALSE), 'normaltemp', NULL, 'Handbook 44', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (764, 'inch', (FALSE), 'cm', '2.54', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (765, 'in', (FALSE), 'inch', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (766, 'foot', (FALSE), 'inch', '12', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (767, 'feet', (FALSE), 'foot', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (768, 'ft', (FALSE), 'foot', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (769, 'Rinfinity', (FALSE), '/m', '10973731.568539', 'The wavelengths of a spectral series', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (770, 'R_H', (FALSE), '/m', '10967760', 'can be expressed as', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (771, 'alpha', (FALSE), '7.2973525664e-3', NULL, 'The fine structure constant was', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (772, 'prout', (FALSE), 'keV', '185.5', 'nuclear binding energy equal to 1|12', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (773, 'planckmass', (FALSE), 'kg', '2.17651e-8', 'sqrt(hbar c / G)', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (774, 'm_P', (FALSE), 'planckmass', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (775, 't_P', (FALSE), 'plancktime', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (776, 'plancklength', (FALSE), 'c', 'plancktime', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (777, 'l_P', (FALSE), 'plancklength', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (778, 'deuteronchargeradius', (FALSE), 'm', '2.1413e-15', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (779, 'protonchargeradius', (FALSE), 'm', '0.8751e-15', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (780, 'electronmass', (FALSE), 'u', '5.48579909070e-4', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (781, 'm_e', (FALSE), 'electronmass', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (782, 'protonmass', (FALSE), 'u', '1.007276466879', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (783, 'm_p', (FALSE), 'protonmass', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (784, 'neutronmass', (FALSE), 'u', '1.00866491588', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (785, 'm_n', (FALSE), 'neutronmass', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (786, 'muonmass', (FALSE), 'u', '0.1134289257', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (787, 'm_mu', (FALSE), 'muonmass', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (788, 'deuteronmass', (FALSE), 'u', '2.013553212745', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (789, 'm_d', (FALSE), 'deuteronmass', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (790, 'alphaparticlemass', (FALSE), 'u', '4.001506179127', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (791, 'm_alpha', (FALSE), 'alphaparticlemass', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (792, 'taumass', (FALSE), 'u', '1.90749', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (793, 'm_tau', (FALSE), 'taumass', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (794, 'tritonmass', (FALSE), 'u', '3.01550071632', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (795, 'm_t', (FALSE), 'tritonmass', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (796, 'helionmass', (FALSE), 'u', '3.01493224673', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (797, 'm_h', (FALSE), 'helionmass', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (798, 'lambda_C', (FALSE), 'electronwavelength', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (799, 'lambda_Cp', (FALSE), 'protonwavelength', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (800, 'lambda_Cn', (FALSE), 'neutronwavelength', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (801, 'mu_B', (FALSE), 'bohrmagneton', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (802, 'mu_N', (FALSE), 'nuclearmagneton', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (803, 'mu_mu', (FALSE), 'J/T', '-4.49044826e-26', 'Muon magnetic moment', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (804, 'mu_p', (FALSE), 'J/T', '1.4106067873e-26', 'Proton magnetic moment', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (805, 'mu_e', (FALSE), 'J/T', '-928.4764620e-26', 'Electron magnetic moment', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (806, 'mu_n', (FALSE), 'J/T', '-0.96623650e-26', 'Neutron magnetic moment', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (807, 'mu_d', (FALSE), 'J/T', '0.4330735040e-26', 'Deuteron magnetic moment', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (808, 'mu_t', (FALSE), 'J/T', '1.504609503e-26', 'Triton magnetic moment', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (809, 'mu_h', (FALSE), 'J/T', '-1.074617522e-26', 'Helion magnetic moment', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (810, 'kgf', (FALSE), 'force', 'kg', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (811, 'at', (FALSE), 'technicalatmosphere', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (812, 'mmHg', (FALSE), 'Hg', 'mm', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (813, 'tor', (FALSE), 'Pa', NULL, 'Suggested in 1913 but seldom used [24].', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (814, 'inHg', (FALSE), 'Hg', 'inch', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (815, 'inH2O', (FALSE), 'water', 'inch', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (816, 'mmH2O', (FALSE), 'water', 'mm', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (817, 'lightyear', (FALSE), 'julianyear', 'c', 'The 365.25 day year is specified in', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (818, 'ly', (FALSE), 'lightyear', NULL, 'NIST publication 811', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (819, 'lightsecond', (FALSE), 's', 'c', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (820, 'lightminute', (FALSE), 'min', 'c', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (821, 'crith', (FALSE), 'gram', '0.089885', 'The crith is the mass of one', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (822, 'amagatvolume', (FALSE), 'molarvolume', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (823, 'amagat', (FALSE), 'mol/amagatvolume', NULL, 'Used to measure gas densities', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (824, 'invcm', (FALSE), 'cminv', NULL, 'spectroscopy.', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (825, 'wavenumber', (FALSE), 'cminv', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (826, 'dyn', (FALSE), 'dyne', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (827, 'erg', (FALSE), 'dyne', 'cm', 'energy', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (828, 'P', (FALSE), 'poise', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (829, 'rhe', (FALSE), '/poise', NULL, 'reciprocal viscosity', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (830, 'St', (FALSE), 'stokes', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (831, 'stoke', (FALSE), 'stokes', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (832, 'lentor', (FALSE), 'stokes', NULL, 'old name', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (833, 'galileo', (FALSE), 'Gal', NULL, 'for earth''s gravitational field', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (834, 'barye', (FALSE), 'dyne/cm^2', NULL, 'pressure', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (835, 'barad', (FALSE), 'barye', NULL, 'old name', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (836, 'kayser', (FALSE), '1/cm', NULL, 'Proposed as a unit for wavenumber', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (837, 'balmer', (FALSE), 'kayser', NULL, 'Even less common name than "kayser"', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (838, 'kine', (FALSE), 'cm/s', NULL, 'velocity', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (839, 'pond', (FALSE), 'force', 'gram', NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (840, 'ray', (FALSE), 'acousticalohm', NULL, NULL, 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (841, 'eotvos', (FALSE), 'Gal/cm', '1e-9', 'Change in gravitational acceleration', 'constants', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (842, 'sec', (FALSE), 's', NULL, NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (843, 'minute', (FALSE), 's', '60', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (844, 'min', (FALSE), 'minute', NULL, NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (845, 'hour', (FALSE), 'min', '60', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (846, 'h', (FALSE), 'hour', NULL, NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (847, 'hr', (FALSE), 'hour', NULL, NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (848, 'day', (FALSE), 'hr', '24', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (849, 'd', (FALSE), 'day', NULL, NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (850, 'da', (FALSE), 'day', NULL, NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (851, 'week', (FALSE), 'day', '7', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (852, 'wk', (FALSE), 'week', NULL, NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (853, 'sennight', (FALSE), 'day', '7', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (854, 'fortnight', (FALSE), 'day', '14', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (855, 'blink', (FALSE), 'day', '1e-5', 'Actual human blink takes 1|3 second', 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (856, 'ce', (FALSE), 'day', '1e-2', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (857, 'cron', (FALSE), 'years', '1e6', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (858, 'watch', (FALSE), 'hours', '4', 'time a sentry stands watch or a ship''s', 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (859, 'bell', (FALSE), 'watch', '1|8', 'Bell would be sounded every 30 minutes.', 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (860, 'decimalhour', (FALSE), 'day', '1|10', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (861, 'decimalminute', (FALSE), 'decimalhour', '1|100', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (862, 'decimalsecond', (FALSE), 'decimalminute', '1|100', NULL, 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (863, 'beat', (FALSE), 'decimalminute', NULL, 'Swatch Internet Time', 'time', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (864, 'N', (FALSE), 'newton', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (865, 'pascal', (FALSE), 'N/m^2', NULL, 'pressure or stress', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (866, 'Pa', (FALSE), 'pascal', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (867, 'joule', (FALSE), 'm', 'N', 'energy', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (868, 'J', (FALSE), 'joule', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (869, 'watt', (FALSE), 'J/s', NULL, 'power', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (870, 'W', (FALSE), 'watt', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (871, 'coulomb', (FALSE), 's', 'A', 'charge', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (872, 'C', (FALSE), 'coulomb', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (873, 'volt', (FALSE), 'W/A', NULL, 'potential difference', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (874, 'V', (FALSE), 'volt', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (875, 'ohm', (FALSE), 'V/A', NULL, 'electrical resistance', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (876, 'siemens', (FALSE), 'A/V', NULL, 'electrical conductance', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (877, 'S', (FALSE), 'siemens', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (878, 'farad', (FALSE), 'C/V', NULL, 'capacitance', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (879, 'F', (FALSE), 'farad', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (880, 'weber', (FALSE), 's', 'V', 'magnetic flux', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (881, 'Wb', (FALSE), 'weber', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (882, 'H', (FALSE), 'henry', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (883, 'tesla', (FALSE), 'Wb/m^2', NULL, 'magnetic flux density', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (884, 'T', (FALSE), 'tesla', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (885, 'hertz', (FALSE), '/s', NULL, 'frequency', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (886, 'Hz', (FALSE), 'hertz', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (887, 'LENGTH', (FALSE), 'meter', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (888, 'AREA', (FALSE), 'LENGTH^2', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (889, 'VOLUME', (FALSE), 'LENGTH^3', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (890, 'MASS', (FALSE), 'kilogram', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (891, 'AMOUNT', (FALSE), 'mole', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (892, 'ANGLE', (FALSE), 'radian', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (893, 'SOLID_ANGLE', (FALSE), 'steradian', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (894, 'MONEY', (FALSE), 'US$', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (895, 'FORCE', (FALSE), 'newton', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (896, 'FREQUENCY', (FALSE), 'hertz', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (897, 'CURRENT', (FALSE), 'ampere', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (898, 'CHARGE', (FALSE), 'coulomb', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (899, 'CAPACITANCE', (FALSE), 'farad', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (900, 'RESISTANCE', (FALSE), 'ohm', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (901, 'CONDUCTANCE', (FALSE), 'siemens', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (904, 'ELECTRIC_DIPOLE_MOMENT', (FALSE), 'm', 'C', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (905, 'ELECTRIC_POTENTIAL', (FALSE), 'volt', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (906, 'VOLTAGE', (FALSE), 'ELECTRIC_POTENTIAL', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (907, 'E_FLUX', (FALSE), 'AREA', 'E_FIELD', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (908, 'D_FLUX', (FALSE), 'AREA', 'D_FIELD', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (909, 'B_FLUX', (FALSE), 'AREA', 'B_FIELD', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (910, 'H_FLUX', (FALSE), 'AREA', 'H_FIELD', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (911, 'gram', (FALSE), 'millikg', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (912, 'gm', (FALSE), 'gram', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (913, 'g', (FALSE), 'gram', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (914, 'tonne', (FALSE), 'kg', '1000', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (915, 't', (FALSE), 'tonne', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (916, 'metricton', (FALSE), 'tonne', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (917, 'funal', (FALSE), 'sthene', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (918, 'quintal', (FALSE), 'kg', '100', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (919, 'bar', (FALSE), 'Pa', '1e5', 'About 1 atm', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (920, 'b', (FALSE), 'bar', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (921, 'vac', (FALSE), 'millibar', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (922, 'micron', (FALSE), 'micrometer', NULL, 'One millionth of a meter', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (923, 'bicron', (FALSE), 'picometer', NULL, 'One brbillionth of a meter', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (924, 'cc', (FALSE), 'cm^3', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (925, 'are', (FALSE), 'm^2', '100', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (926, 'a', (FALSE), 'are', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (927, 'liter', (FALSE), 'cc', '1000', 'The liter was defined in 1901 as the', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (928, 'oldliter', (FALSE), 'dm^3', '1.000028', 'space occupied by 1 kg of pure water at', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (929, 'L', (FALSE), 'liter', NULL, 'the temperature of its maximum density', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (930, 'l', (FALSE), 'liter', NULL, 'under a pressure of 1 atm.  This was', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (931, 'mho', (FALSE), 'siemens', NULL, 'Inverse of ohm, hence ohm spelled backward', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (932, 'galvat', (FALSE), 'ampere', NULL, 'Named after Luigi Galvani', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (933, 'angstrom', (FALSE), 'm', '1e-10', 'Convenient for describing molecular sizes', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (934, 'xunit', (FALSE), 'xunit_cu', NULL, 'Used for measuring x-ray wavelengths.', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (935, 'siegbahn', (FALSE), 'xunit', NULL, 'Originally defined to be 1|3029.45 of', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (936, 'xunit_cu', (FALSE), 'm', '1.00207697e-13', 'the spacing of calcite planes at 18', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (937, 'xunit_mo', (FALSE), 'm', '1.00209952e-13', 'degC.  It was intended to be exactly', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (938, 'angstromstar', (FALSE), 'angstrom', '1.00001495', 'Defined by JA Bearden in 1965', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (939, 'fermi', (FALSE), 'm', '1e-15', 'Convenient for describing nuclear sizes', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (940, 'barn', (FALSE), 'm^2', '1e-28', 'Used to measure cross section for', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (941, 'shed', (FALSE), 'barn', '1e-24', 'Defined to be a smaller companion to the', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (942, 'brewster', (FALSE), 'micron^2/N', NULL, 'measures stress-optical coef', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (943, 'diopter', (FALSE), '/m', NULL, 'measures reciprocal of lens focal length', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (944, 'fresnel', (FALSE), 'Hz', '1e12', 'occasionally used in spectroscopy', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (945, 'shake', (FALSE), 'sec', '1e-8', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (946, 'svedberg', (FALSE), 's', '1e-13', 'Used for measuring the sedimentation', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (947, 'gamma', (FALSE), 'microgram', NULL, 'Also used for 1e-9 tesla', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (948, 'lambda', (FALSE), 'microliter', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (949, 'spat', (FALSE), 'm', '1e12', 'Rarely used for astronomical measurements', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (950, 'planck', (FALSE), 's', 'J', 'action of one joule over one second', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (951, 'sturgeon', (FALSE), '/henry', NULL, 'magnetic reluctance', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (952, 'daraf', (FALSE), '1/farad', NULL, 'elastance (farad spelled backwards)', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (953, 'leo', (FALSE), 'm/s^2', '10', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (954, 'mayer', (FALSE), 'K', 'J/g', 'specific heat', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (955, 'mired', (FALSE), 'microK', '/', 'reciprocal color temperature.  The name', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (956, 'crocodile', (FALSE), 'megavolt', NULL, 'used informally in UK physics labs', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (957, 'metricounce', (FALSE), 'g', '25', NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (958, 'mounce', (FALSE), 'metricounce', NULL, NULL, 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (959, 'finsenunit', (FALSE), 'W/m^2', '1e5', 'Measures intensity of ultraviolet light', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (960, 'jansky', (FALSE), 'fluxunit', NULL, 'K. G. Jansky identified radio waves coming', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (961, 'Jy', (FALSE), 'jansky', NULL, 'from outer space in 1931.', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (962, 'katal', (FALSE), 'mol/sec', NULL, 'Measure of the amount of a catalyst.  One', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (963, 'kat', (FALSE), 'katal', NULL, 'katal of catalyst enables the reaction', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (964, 'solarluminosity', (FALSE), 'W', '382.8e24', 'A common yardstick for comparing the', 'derived', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (965, 'TEMPERATURE', (FALSE), 'kelvin', NULL, NULL, 'temperature', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (966, 'TEMPERATURE_DIFFERENCE', (FALSE), 'kelvin', NULL, NULL, 'temperature', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (967, 'tempcelsius()', (FALSE), 'tempC', NULL, NULL, 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (968, 'degcelsius', (FALSE), 'K', NULL, NULL, 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (969, 'degC', (FALSE), 'K', NULL, NULL, 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (970, 'tempfahrenheit()', (FALSE), 'tempF', NULL, NULL, 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (971, 'degreesrankine', (FALSE), 'degF', NULL, 'The Rankine scale has the', 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (972, 'degrankine', (FALSE), 'degreesrankine', NULL, 'Fahrenheit degree, but its zero', 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (973, 'degreerankine', (FALSE), 'degF', NULL, 'is at absolute zero.', 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (974, 'degR', (FALSE), 'degrankine', NULL, NULL, 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (975, 'tempR', (FALSE), 'degrankine', NULL, NULL, 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (976, 'temprankine', (FALSE), 'degrankine', NULL, NULL, 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (977, 'degK', (FALSE), 'K', NULL, '"Degrees Kelvin" is forbidden usage.', 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (978, 'tempK', (FALSE), 'K', NULL, 'For consistency', 'temperature', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (979, 'degree', (FALSE), 'circle', '1|360', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (980, 'deg', (FALSE), 'degree', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (981, 'arcdeg', (FALSE), 'degree', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (982, 'arcmin', (FALSE), 'degree', '1|60', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (983, 'arcminute', (FALSE), 'arcmin', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (984, '''', (FALSE), 'arcmin', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (985, 'arcsec', (FALSE), 'arcmin', '1|60', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (986, 'arcsecond', (FALSE), 'arcsec', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (987, '"', (FALSE), 'arcsec', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (988, '''''', (FALSE), '"', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (989, 'rightangle', (FALSE), 'degrees', '90', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (990, 'quadrant', (FALSE), 'circle', '1|4', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (991, 'quintant', (FALSE), 'circle', '1|5', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (992, 'sextant', (FALSE), 'circle', '1|6', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (993, 'sign', (FALSE), 'circle', '1|12', 'Angular extent of one sign of the zodiac', 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (994, 'turn', (FALSE), 'circle', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (995, 'revolution', (FALSE), 'turn', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (996, 'rev', (FALSE), 'turn', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (997, 'gon', (FALSE), 'rightangle', '1|100', 'measure of grade', 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (998, 'grade', (FALSE), 'gon', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (999, 'centesimalminute', (FALSE), 'grade', '1|100', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1000, 'centesimalsecond', (FALSE), 'centesimalminute', '1|100', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1001, 'milangle', (FALSE), 'circle', '1|6400', 'Official NIST definition.', 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1002, 'pointangle', (FALSE), 'circle', '1|32', 'Used for reporting compass readings', 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1003, 'centrad', (FALSE), 'radian', '0.01', 'Used for angular deviation of light', 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1004, 'mas', (FALSE), 'milliarcsec', NULL, 'Used by astronomers', 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1005, 'seclongitude', (FALSE), '(seconds/day)', 'circle', 'Astronomers measure longitude', 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1006, 'squareminute', (FALSE), 'squaredegree', '1|60^2', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1007, 'squaresecond', (FALSE), 'squareminute', '1|60^2', NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1008, 'squarearcmin', (FALSE), 'squareminute', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1009, 'squarearcsec', (FALSE), 'squaresecond', NULL, NULL, 'angles', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1010, 'percent', (FALSE), '0.01', NULL, NULL, 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1011, '%', (FALSE), 'percent', NULL, NULL, 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1012, 'mill', (FALSE), '0.001', NULL, 'Originally established by Congress in 1791', 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1013, 'proof', (FALSE), '1|200', NULL, 'Alcohol content measured by volume at', 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1014, 'ppm', (FALSE), '1e-6', NULL, NULL, 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1015, 'partspermillion', (FALSE), 'ppm', NULL, NULL, 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1016, 'ppb', (FALSE), '1e-9', NULL, NULL, 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1017, 'partsperbillion', (FALSE), 'ppb', NULL, 'USA billion', 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1018, 'ppt', (FALSE), '1e-12', NULL, NULL, 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1019, 'partspertrillion', (FALSE), 'ppt', NULL, 'USA trillion', 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1020, 'karat', (FALSE), '1|24', NULL, 'measure of gold purity', 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1021, 'caratgold', (FALSE), 'karat', NULL, NULL, 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1022, 'gammil', (FALSE), 'mg/l', NULL, NULL, 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1023, 'basispoint', (FALSE), '%', '0.01', 'Used in finance', 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1024, 'fine', (FALSE), '1|1000', NULL, 'Measure of gold purity', 'concentration', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1025, 'tbl', (FALSE), 'tablespoon', NULL, NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1026, 'tbsp', (FALSE), 'tablespoon', NULL, NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1027, 'tblsp', (FALSE), 'tablespoon', NULL, NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1028, 'Tb', (FALSE), 'tablespoon', NULL, NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1029, 'tsp', (FALSE), 'teaspoon', NULL, NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1030, 'saltspoon', (FALSE), 'tsp', '1|4', NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1031, 'uscup', (FALSE), 'usfloz', '8', NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1032, 'ustablespoon', (FALSE), 'uscup', '1|16', NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1033, 'usteaspoon', (FALSE), 'ustablespoon', '1|3', NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1034, 'ustbl', (FALSE), 'ustablespoon', NULL, NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1035, 'ustbsp', (FALSE), 'ustablespoon', NULL, NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1036, 'ustblsp', (FALSE), 'ustablespoon', NULL, NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1037, 'ustsp', (FALSE), 'usteaspoon', NULL, NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1038, 'metriccup', (FALSE), 'ml', '250', NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1039, 'stickbutter', (FALSE), 'lb', '1|4', 'Butter in the USA is sold in one', 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1040, 'legalcup', (FALSE), 'ml', '240', 'The cup used on nutrition labeling', 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1041, 'legaltablespoon', (FALSE), 'legalcup', '1|16', NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1042, 'legaltbsp', (FALSE), 'legaltablespoon', NULL, NULL, 'cooking', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1043, 'number1can', (FALSE), 'usfloz', '10', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1044, 'number2can', (FALSE), 'usfloz', '19', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1045, 'number2_5can', (FALSE), 'uscups', '3.5', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1046, 'number3can', (FALSE), 'uscups', '4', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1047, 'number5can', (FALSE), 'uscups', '7', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1048, 'number10can', (FALSE), 'usfloz', '105', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1049, 'brcup', (FALSE), 'brpint', '1|2', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1050, 'brteacup', (FALSE), 'brpint', '1|3', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1051, 'brtablespoon', (FALSE), 'ml', '15', 'Also 5|8 brfloz, approx 17.7 ml', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1052, 'brteaspoon', (FALSE), 'brtablespoon', '1|3', 'Also 1|4 brtablespoon', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1053, 'brdessertspoon', (FALSE), 'brteaspoon', '2', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1054, 'dessertspoon', (FALSE), 'brdessertspoon', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1055, 'dsp', (FALSE), 'dessertspoon', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1056, 'brtsp', (FALSE), 'brteaspoon', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1057, 'brtbl', (FALSE), 'brtablespoon', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1058, 'brtbsp', (FALSE), 'brtablespoon', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1059, 'brtblsp', (FALSE), 'brtablespoon', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1060, 'australiatablespoon', (FALSE), 'ml', '20', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1061, 'austbl', (FALSE), 'australiatablespoon', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1062, 'austbsp', (FALSE), 'australiatablespoon', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1063, 'austblsp', (FALSE), 'australiatablespoon', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1064, 'australiateaspoon', (FALSE), 'australiatablespoon', '1|4', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1065, 'austsp', (FALSE), 'australiateaspoon', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1066, 'etto', (FALSE), 'g', '100', 'Used for buying items like meat and', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1067, 'etti', (FALSE), 'etto', NULL, 'cheese.', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1068, 'catty', (FALSE), 'kg', '0.5', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1069, 'oldcatty', (FALSE), 'lbs', '4|3', 'Before metric conversion.', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1070, 'tael', (FALSE), 'oldcatty', '1|16', 'Should the tael be defined both ways?', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1071, 'mace', (FALSE), 'tael', '0.1', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1072, 'oldpicul', (FALSE), 'oldcatty', '100', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1073, 'picul', (FALSE), 'catty', '100', 'Chinese usage', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1074, 'seer', (FALSE), 'grain', '14400', 'British Colonial standard', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1075, 'ser', (FALSE), 'seer', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1076, 'maund', (FALSE), 'seer', '40', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1077, 'pakistanseer', (FALSE), 'kg', '1', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1078, 'pakistanmaund', (FALSE), 'pakistanseer', '40', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1079, 'chittak', (FALSE), 'seer', '1|16', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1080, 'tola', (FALSE), 'chittak', '1|5', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1081, 'ollock', (FALSE), 'liter', '1|4', 'Is this right?', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1082, 'japancup', (FALSE), 'ml', '200', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1083, 'butter', (FALSE), 'oz/uscup', '8', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1084, 'butter_clarified', (FALSE), 'oz/uscup', '6.8', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1085, 'cocoa_butter', (FALSE), 'oz/uscup', '9', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1086, 'shortening', (FALSE), 'oz/uscup', '6.75', 'vegetable shortening', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1087, 'oil', (FALSE), 'oz/uscup', '7.5', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1088, 'cakeflour_sifted', (FALSE), 'oz/uscup', '3.5', 'The density of flour depends on the', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1089, 'cakeflour_spooned', (FALSE), 'oz/uscup', '4', 'measuring method.  "Scooped",  or', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1090, 'cakeflour_scooped', (FALSE), 'oz/uscup', '4.5', '"dip and sweep" refers to dipping a', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1091, 'flour_sifted', (FALSE), 'oz/uscup', '4', 'measure into a bin, and then sweeping', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1092, 'flour_spooned', (FALSE), 'oz/uscup', '4.25', 'the excess off the top.  "Spooned"', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1093, 'flour_scooped', (FALSE), 'oz/uscup', '5', 'means to lightly spoon into a measure', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1094, 'breadflour_sifted', (FALSE), 'oz/uscup', '4.25', 'and then sweep the top.  Sifted means', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1095, 'breadflour_spooned', (FALSE), 'oz/uscup', '4.5', 'sifting the flour directly into a', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1096, 'breadflour_scooped', (FALSE), 'oz/uscup', '5.5', 'measure and then sweeping the top.', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1097, 'cornstarch', (FALSE), 'grams/uscup', '120', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1098, 'dutchcocoa_sifted', (FALSE), 'g/uscup', '75', 'These are for Dutch processed cocoa', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1099, 'dutchcocoa_spooned', (FALSE), 'g/uscup', '92', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1100, 'dutchcocoa_scooped', (FALSE), 'g/uscup', '95', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1101, 'cocoa_sifted', (FALSE), 'g/uscup', '75', 'These are for nonalkalized cocoa', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1102, 'cocoa_spooned', (FALSE), 'g/uscup', '82', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1103, 'cocoa_scooped', (FALSE), 'g/uscup', '95', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1104, 'heavycream', (FALSE), 'g/uscup', '232', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1105, 'milk', (FALSE), 'g/uscup', '242', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1106, 'sourcream', (FALSE), 'g/uscup', '242', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1107, 'molasses', (FALSE), 'oz/uscup', '11.25', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1108, 'cornsyrup', (FALSE), 'oz/uscup', '11.5', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1109, 'honey', (FALSE), 'oz/uscup', '11.75', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1110, 'sugar', (FALSE), 'g/uscup', '200', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1111, 'powdered_sugar', (FALSE), 'oz/uscup', '4', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1112, 'brownsugar_light', (FALSE), 'g/uscup', '217', 'packed', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1113, 'brownsugar_dark', (FALSE), 'g/uscup', '239', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1114, 'egg', (FALSE), 'grams', '50', 'without shell', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1115, 'eggwhite', (FALSE), 'grams', '30', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1116, 'eggyolk', (FALSE), 'grams', '18.6', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1117, 'eggwhitevolume', (FALSE), 'ustablespoons', '2', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1118, 'eggyolkvolume', (FALSE), 'ustsp', '3.5', NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1119, 'ethanoldensity', (FALSE), 'g/cm^3', '0.7893', 'From CRC Handbook, 91st Edition', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1120, 'alcoholdensity', (FALSE), 'ethanoldensity', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1121, 'brix(~sugar_conc_bpe(T-tempC(100)))', (FALSE), ';\', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1122, 'brix(~sugar_conc_bpe(tempF(T)+-tempC(100)))', (FALSE), ';\', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1123, 'brix(~sugar_conc_bpe(tempC(T)+-tempC(100)))', (FALSE), ';\', NULL, NULL, 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1124, 'baumeconst', (FALSE), '145', NULL, 'US value', 'cooking', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1125, 'pdl', (FALSE), 'poundal', NULL, NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1126, 'psia', (FALSE), 'psi', NULL, 'absolute pressure', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1127, 'reyn', (FALSE), 'sec', 'psi', NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1128, 'slugf', (FALSE), 'force', 'slug', NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1129, 'slinchf', (FALSE), 'force', 'slinch', 'pound-force system.  Used in space', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1130, 'geepound', (FALSE), 'slug', NULL, NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1131, 'lbf', (FALSE), 'force', 'lb', NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1132, 'tonf', (FALSE), 'force', 'ton', NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1133, 'lbm', (FALSE), 'lb', NULL, NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1134, 'kip', (FALSE), 'lbf', '1000', 'from kilopound', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1135, 'mil', (FALSE), 'inch', '0.001', NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1136, 'thou', (FALSE), 'inch', '0.001', NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1137, 'tenth', (FALSE), 'inch', '0.0001', 'one tenth of one thousandth of an inch', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1138, 'millionth', (FALSE), 'inch', '1e-6', 'one millionth of an inch', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1139, 'circleinch', (FALSE), 'circularinch', NULL, 'A circle with diameter d inches has', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1140, 'cylinderinch', (FALSE), 'inch', 'circleinch', 'Cylinder h inch tall, d inches diameter', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1141, 'cmil', (FALSE), 'circularmil', NULL, NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1142, 'cental', (FALSE), 'pound', '100', NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1143, 'centner', (FALSE), 'cental', NULL, NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1144, 'caliber', (FALSE), 'inch', '0.01', 'for measuring bullets', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1145, 'duty', (FALSE), 'lbf', 'ft', NULL, 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1146, 'australiapoint', (FALSE), 'inch', '0.01', 'The "point" is used to measure rainfall', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1147, 'sabin', (FALSE), 'ft^2', NULL, 'Measure of sound absorption equal to the', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1148, 'flag', (FALSE), 'ft^2', '5', 'Construction term referring to sidewalk.', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1149, 'rollwallpaper', (FALSE), 'ft^2', '30', 'Area of roll of wall paper', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1150, 'pinlength', (FALSE), 'inch', '1|16', 'A', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1151, 'buttonline', (FALSE), 'inch', '1|40', 'The line was used in 19th century USA', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1152, 'beespace', (FALSE), 'inch', '1|4', 'Bees will fill any space that is smaller', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1153, 'diamond', (FALSE), 'ft', '8|5', 'Marking on US tape measures that is', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1154, 'retmaunit', (FALSE), 'in', '1.75', 'Height of rack mountable equipment.', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1155, 'U', (FALSE), 'retmaunit', NULL, 'Equipment should be 1|32 inch narrower', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1156, 'RU', (FALSE), 'U', NULL, 'than its U measurement indicates to', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1157, 'count', (FALSE), 'pound', 'per', 'For measuring the size of shrimp', 'imperial', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1158, 'ENERGY', (FALSE), 'joule', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1159, 'WORK', (FALSE), 'joule', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1160, 'calorie', (FALSE), 'cal_th', NULL, 'Default is the thermochemical calorie', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1161, 'cal', (FALSE), 'calorie', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1162, 'calorie_th', (FALSE), 'J', '4.184', 'Thermochemical calorie, defined in 1930', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1163, 'thermcalorie', (FALSE), 'calorie_th', NULL, 'by Frederick Rossini as 4.1833 J to', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1164, 'cal_th', (FALSE), 'calorie_th', NULL, 'avoid difficulties associated with the', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1165, 'calorie_IT', (FALSE), 'J', '4.1868', 'International (Steam) Table calorie,', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1166, 'cal_IT', (FALSE), 'calorie_IT', NULL, 'defined in 1929 as watt-hour/860 or', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1167, 'calorie_15', (FALSE), 'J', '4.18580', 'Energy to go from 14.5 to 15.5 degC', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1168, 'cal_15', (FALSE), 'calorie_15', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1169, 'calorie_fifteen', (FALSE), 'cal_15', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1170, 'calorie_20', (FALSE), 'J', '4.18190', 'Energy to go from 19.5 to 20.5 degC', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1171, 'cal_20', (FALSE), 'calorie_20', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1172, 'calorie_twenty', (FALSE), 'calorie_20', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1173, 'calorie_4', (FALSE), 'J', '4.204', 'Energy to go from 3.5 to 4.5 degC', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1174, 'cal_4', (FALSE), 'calorie_4', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1175, 'calorie_four', (FALSE), 'calorie_4', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1176, 'cal_mean', (FALSE), 'J', '4.19002', '1|100 energy to go from 0 to 100 degC', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1177, 'Calorie', (FALSE), 'kilocalorie', NULL, 'the food Calorie', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1178, 'thermie', (FALSE), 'cal_15', '1e6', 'Heat required to raise the', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1179, 'btu', (FALSE), 'btu_IT', NULL, 'International Table BTU is the default', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1180, 'britishthermalunit', (FALSE), 'btu', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1181, 'btu_ISO', (FALSE), 'J', '1055.06', 'Exact, rounded ISO definition based', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1182, 'quad', (FALSE), 'btu', 'quadrillion', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1183, 'ECtherm', (FALSE), 'btu_ISO', '1e5', 'Exact definition', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1184, 'UStherm', (FALSE), 'J', '1.054804e8', 'Exact definition,', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1185, 'therm', (FALSE), 'UStherm', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1186, 'water_vaporization_heat', (FALSE), 'J/g', '2256.4', 'At saturation, 100 deg C, 101.42 kPa', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1187, 'water_specificheat', (FALSE), 'specificheat_water', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1188, 'tonoil', (FALSE), 'cal_IT', '1e10', 'Ton oil equivalent.  A conventional', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1189, 'toe', (FALSE), 'tonoil', NULL, 'burning one metric ton of oil. [18,E2]', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1190, 'toncoal', (FALSE), 'cal_IT', '7e9', 'Energy in metric ton coal from [18].', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1191, 'barreloil', (FALSE), 'Mbtu', '5.8', 'Conventional value for barrel of crude', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1192, 'naturalgas_HHV', (FALSE), 'btu/ft^3', '1027', 'Energy content of natural gas.  HHV', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1193, 'naturalgas_LHV', (FALSE), 'btu/ft^3', '930', 'is for Higher Heating Value and', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1194, 'naturalgas', (FALSE), 'naturalgas_HHV', NULL, 'includes energy from condensation', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1195, 'charcoal', (FALSE), 'GJ/tonne', '30', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1196, 'woodenergy_dry', (FALSE), 'GJ/tonne', '20', 'HHV, a cord weights about a tonne', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1197, 'woodenergy_airdry', (FALSE), 'GJ/tonne', '15', '20% moisture content', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1198, 'ethanol_HHV', (FALSE), 'btu/usgallon', '84000', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1199, 'ethanol_LHV', (FALSE), 'btu/usgallon', '75700', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1200, 'diesel', (FALSE), 'btu/usgallon', '130500', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1201, 'gasoline_LHV', (FALSE), 'btu/usgallon', '115000', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1202, 'gasoline_HHV', (FALSE), 'btu/usgallon', '125000', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1203, 'gasoline', (FALSE), 'gasoline_HHV', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1204, 'heating', (FALSE), 'MJ/liter', '37.3', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1205, 'fueloil', (FALSE), 'MJ/liter', '39.7', 'low sulphur', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1206, 'propane', (FALSE), 'MJ/m^3', '93.3', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1207, 'butane', (FALSE), 'MJ/m^3', '124', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1208, 'uranium_natural', (FALSE), 'uranium_pure', '0.7%', 'Natural uranium: 0.7% U-235', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1209, 'chu', (FALSE), 'celsiusheatunit', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1210, 'POWER', (FALSE), 'watt', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1211, 'VA', (FALSE), 'ampere', 'volt', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1212, 'kWh', (FALSE), 'hour', 'kilowatt', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1213, 'mechanicalhorsepower', (FALSE), 'horsepower', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1214, 'hp', (FALSE), 'horsepower', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1215, 'electrichorsepower', (FALSE), 'W', '746', 'Germany', 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1216, 'boilerhorsepower', (FALSE), 'W', '9809.50', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1217, 'waterhorsepower', (FALSE), 'W', '746.043', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1218, 'brhorsepower', (FALSE), 'W', '745.70', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1219, 'donkeypower', (FALSE), 'W', '250', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1220, 'chevalvapeur', (FALSE), 'metrichorsepower', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1221, 'THERMAL_RESISTIVITY', (FALSE), '1/THERMAL_CONDUCTIVITY', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1222, 'THERMAL_RESISTANCE', (FALSE), '1/THERMAL_CONDUCTANCE', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1223, 'THERMAL_INSULANCE', (FALSE), 'LENGTH', 'THERMAL_RESISTIVITY', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1224, 'THERMAL_INSULATION', (FALSE), 'LENGTH', 'THERMAL_RESISTIVITY', NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1225, 'Uvalue', (FALSE), '1/Rvalue', NULL, NULL, 'energy', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1226, 'dB()', (FALSE), 'decibel', NULL, 'Abbreviation', 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1227, 'clausius', (FALSE), 'cal/K', '1e3', 'A unit of physical entropy', 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1228, 'langley', (FALSE), 'thermcalorie/cm^2', NULL, 'Used in radiation theory', 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1229, 'tonref', (FALSE), 'tonrefrigeration', NULL, NULL, 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1230, 'frigorie', (FALSE), 'cal_15', '1000', 'Used in refrigeration engineering.', 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1231, 'fatman', (FALSE), 'nagasaki', NULL, NULL, 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1232, 'littleboy', (FALSE), 'hiroshima', NULL, NULL, 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1233, 'gadget', (FALSE), 'trinity', NULL, NULL, 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1234, 'perm_zero', (FALSE), 'perm_0C', NULL, NULL, 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1235, 'perm_0', (FALSE), 'perm_0C', NULL, NULL, 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1236, 'perm', (FALSE), 'perm_0C', NULL, NULL, 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1237, 'perm_twentythree', (FALSE), 'perm_23C', NULL, NULL, 'energy', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1238, 'pair', (FALSE), '2', NULL, NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1239, 'brace', (FALSE), '2', NULL, NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1240, 'nest', (FALSE), '3', NULL, 'often used for items like bowls that', 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1241, 'hattrick', (FALSE), '3', NULL, 'Used in sports, especially cricket and ice', 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1242, 'dicker', (FALSE), '10', NULL, NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1243, 'dozen', (FALSE), '12', NULL, NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1244, 'bakersdozen', (FALSE), '13', NULL, NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1245, 'score', (FALSE), '20', NULL, NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1246, 'flock', (FALSE), '40', NULL, NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1247, 'timer', (FALSE), '40', NULL, NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1248, 'shock', (FALSE), '60', NULL, NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1249, 'toncount', (FALSE), '100', NULL, 'Used in sports in the UK', 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1250, 'longhundred', (FALSE), '120', NULL, 'From a germanic counting system', 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1251, 'gross', (FALSE), '144', NULL, NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1252, 'greatgross', (FALSE), 'gross', '12', NULL, 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1253, 'tithe', (FALSE), '1|10', NULL, 'From Anglo-Saxon word for tenth', 'count', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1254, 'shortquire', (FALSE), '24', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1255, 'quire', (FALSE), '25', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1256, 'shortream', (FALSE), '480', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1257, 'ream', (FALSE), '500', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1258, 'perfectream', (FALSE), '516', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1259, 'bundle', (FALSE), 'reams', '2', NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1260, 'bale', (FALSE), 'bundles', '5', NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1261, 'lbbook', (FALSE), 'poundbookpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1262, 'poundtextpaper', (FALSE), 'poundbookpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1263, 'lbtext', (FALSE), 'poundtextpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1264, 'poundoffsetpaper', (FALSE), 'poundbookpaper', NULL, 'For offset printing', 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1265, 'lboffset', (FALSE), 'poundoffsetpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1266, 'poundbiblepaper', (FALSE), 'poundbookpaper', NULL, 'Designed to be lightweight, thin,', 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1267, 'lbbible', (FALSE), 'poundbiblepaper', NULL, 'strong and opaque.', 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1268, 'lbtag', (FALSE), 'poundtagpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1269, 'poundbagpaper', (FALSE), 'poundtagpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1270, 'lbbag', (FALSE), 'poundbagpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1271, 'poundnewsprintpaper', (FALSE), 'poundtagpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1272, 'lbnewsprint', (FALSE), 'poundnewsprintpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1273, 'poundposterpaper', (FALSE), 'poundtagpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1274, 'lbposter', (FALSE), 'poundposterpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1275, 'poundtissuepaper', (FALSE), 'poundtagpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1276, 'lbtissue', (FALSE), 'poundtissuepaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1277, 'poundwrappingpaper', (FALSE), 'poundtagpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1278, 'lbwrapping', (FALSE), 'poundwrappingpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1279, 'poundwaxingpaper', (FALSE), 'poundtagpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1280, 'lbwaxing', (FALSE), 'poundwaxingpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1281, 'poundglassinepaper', (FALSE), 'poundtagpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1282, 'lbglassine', (FALSE), 'poundglassinepaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1283, 'lbcover', (FALSE), 'poundcoverpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1284, 'lbindex', (FALSE), 'poundindexpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1285, 'poundindexbristolpaper', (FALSE), 'poundindexpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1286, 'lbindexbristol', (FALSE), 'poundindexpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1287, 'lbbond', (FALSE), 'poundbondpaper', NULL, 'durable for repeated', 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1288, 'poundwritingpaper', (FALSE), 'poundbondpaper', NULL, 'filing, and it resists', 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1289, 'lbwriting', (FALSE), 'poundwritingpaper', NULL, 'ink penetration.', 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1290, 'poundledgerpaper', (FALSE), 'poundbondpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1291, 'lbledger', (FALSE), 'poundledgerpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1292, 'poundcopypaper', (FALSE), 'poundbondpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1293, 'lbcopy', (FALSE), 'poundcopypaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1294, 'lbblotting', (FALSE), 'poundblottingpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1295, 'lbblanks', (FALSE), 'poundblankspaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1296, 'lbpostcard', (FALSE), 'poundpostcardpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1297, 'poundweddingbristol', (FALSE), 'poundpostcardpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1298, 'lbweddingbristol', (FALSE), 'poundweddingbristol', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1299, 'poundbristolpaper', (FALSE), 'poundweddingbristol', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1300, 'lbbristol', (FALSE), 'poundbristolpaper', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1301, 'lbboxboard', (FALSE), 'poundboxboard', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1302, 'poundpaperboard', (FALSE), 'poundboxboard', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1303, 'lbpaperboard', (FALSE), 'poundpaperboard', NULL, NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1304, 'pointthickness', (FALSE), 'in', '0.001', NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1305, 'paperdensity', (FALSE), 'g/cm^3', '0.8', 'approximate--paper densities vary!', 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1306, 'papercaliper', (FALSE), 'paperdensity', 'in', NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1307, 'paperpoint', (FALSE), 'paperdensity', 'pointthickness', NULL, 'paper', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1308, 'olddidotpoint', (FALSE), 'frenchinch', '1|72', 'François Ambroise Didot, one of', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1309, 'bertholdpoint', (FALSE), 'm', '1|2660', 'H. Berthold tried to create a', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1310, 'INpoint', (FALSE), 'mm', '0.4', 'This point was created by a', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1311, 'germandidotpoint', (FALSE), 'mm', '0.376065', 'Exact definition appears in DIN', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1312, 'metricpoint', (FALSE), 'mm', '3|8', 'Proposed in 1977 by Eurograf', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1313, 'oldpoint', (FALSE), 'inch', '1|72.27', 'The American point was invented', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1314, 'printerspoint', (FALSE), 'oldpoint', NULL, 'by Nelson Hawks in 1879 and', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1315, 'texpoint', (FALSE), 'oldpoint', NULL, 'dominates USA publishing.', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1316, 'texscaledpoint', (FALSE), 'texpoint', '1|65536', 'The TeX typesetting system uses', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1317, 'texsp', (FALSE), 'texscaledpoint', NULL, 'this for all computations.', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1318, 'computerpoint', (FALSE), 'inch', '1|72', 'The American point was rounded', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1319, 'point', (FALSE), 'computerpoint', NULL, NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1320, 'computerpica', (FALSE), 'computerpoint', '12', 'to an even 1|72 inch by computer', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1321, 'postscriptpoint', (FALSE), 'computerpoint', NULL, 'people at some point.', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1322, 'pspoint', (FALSE), 'postscriptpoint', NULL, NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1323, 'twip', (FALSE), 'point', '1|20', 'TWentieth of an Imperial Point', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1324, 'Q', (FALSE), 'mm', '1|4', 'Used in Japanese phototypesetting', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1325, 'frenchprinterspoint', (FALSE), 'olddidotpoint', NULL, NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1326, 'didotpoint', (FALSE), 'germandidotpoint', NULL, 'This seems to be the dominant value', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1327, 'europeanpoint', (FALSE), 'didotpoint', NULL, 'for the point used in Europe', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1328, 'cicero', (FALSE), 'didotpoint', '12', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1329, 'stick', (FALSE), 'in', '2', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1330, 'excelsior', (FALSE), 'oldpoint', '3', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1331, 'brilliant', (FALSE), 'oldpoint', '3.5', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1332, 'diamondtype', (FALSE), 'oldpoint', '4', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1333, 'pearl', (FALSE), 'oldpoint', '5', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1334, 'agate', (FALSE), 'oldpoint', '5.5', 'Originally agate type was 14 lines per', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1335, 'ruby', (FALSE), 'agate', NULL, 'British', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1336, 'nonpareil', (FALSE), 'oldpoint', '6', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1337, 'mignonette', (FALSE), 'oldpoint', '6.5', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1338, 'emerald', (FALSE), 'mignonette', NULL, 'British', 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1339, 'minion', (FALSE), 'oldpoint', '7', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1340, 'brevier', (FALSE), 'oldpoint', '8', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1341, 'bourgeois', (FALSE), 'oldpoint', '9', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1342, 'longprimer', (FALSE), 'oldpoint', '10', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1343, 'smallpica', (FALSE), 'oldpoint', '11', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1344, 'pica', (FALSE), 'oldpoint', '12', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1345, 'english', (FALSE), 'oldpoint', '14', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1346, 'columbian', (FALSE), 'oldpoint', '16', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1347, 'greatprimer', (FALSE), 'oldpoint', '18', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1348, 'paragon', (FALSE), 'oldpoint', '20', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1349, 'meridian', (FALSE), 'oldpoint', '44', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1350, 'canon', (FALSE), 'oldpoint', '48', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1351, 'nonplusultra', (FALSE), 'didotpoint', '2', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1352, 'brillant', (FALSE), 'didotpoint', '3', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1353, 'diamant', (FALSE), 'didotpoint', '4', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1354, 'perl', (FALSE), 'didotpoint', '5', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1355, 'nonpareille', (FALSE), 'didotpoint', '6', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1356, 'kolonel', (FALSE), 'didotpoint', '7', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1357, 'petit', (FALSE), 'didotpoint', '8', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1358, 'borgis', (FALSE), 'didotpoint', '9', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1359, 'korpus', (FALSE), 'didotpoint', '10', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1360, 'corpus', (FALSE), 'korpus', NULL, NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1361, 'garamond', (FALSE), 'korpus', NULL, NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1362, 'mittel', (FALSE), 'didotpoint', '14', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1363, 'tertia', (FALSE), 'didotpoint', '16', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1364, 'text', (FALSE), 'didotpoint', '18', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1365, 'kleine_kanon', (FALSE), 'didotpoint', '32', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1366, 'kanon', (FALSE), 'didotpoint', '36', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1367, 'grobe_kanon', (FALSE), 'didotpoint', '42', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1368, 'missal', (FALSE), 'didotpoint', '48', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1369, 'kleine_sabon', (FALSE), 'didotpoint', '72', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1370, 'grobe_sabon', (FALSE), 'didotpoint', '84', NULL, 'print', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1371, 'INFORMATION', (FALSE), 'bit', NULL, NULL, 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1372, 'nat', (FALSE), 'bits', '(1/0.693147180559945)', 'Entropy measured base e', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1373, 'hartley', (FALSE), 'bits', '3.321928094887363', 'Entropy of a uniformly', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1374, 'ban', (FALSE), 'hartley', NULL, 'distributed random variable', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1375, 'dit', (FALSE), 'hartley', NULL, 'from Decimal digIT', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1376, 'bps', (FALSE), 'bit/sec', NULL, 'Sometimes the term "baud" is', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1377, 'octet', (FALSE), 'bits', '8', 'The octet is always 8 bits', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1378, 'nybble', (FALSE), 'bits', '4', 'Half of a byte. Sometimes', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1379, 'nibble', (FALSE), 'nybble', NULL, NULL, 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1380, 'nyp', (FALSE), 'bits', '2', 'Donald Knuth asks in an exercise', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1381, 'meg', (FALSE), 'megabyte', NULL, 'Some people consider these', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1701, 'nmi', (FALSE), 'nauticalmile', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1382, 'gig', (FALSE), 'gigabyte', NULL, 'to be defined according to', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1383, 'jiffy', (FALSE), 'sec', '0.01', 'This is defined in the Jargon File', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1384, 'jiffies', (FALSE), 'jiffy', NULL, '(http://www.jargon.org) as being the', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1385, 'dvdspeed', (FALSE), 'kB/s', '1385', 'This is the "1x" speed of a DVD using', 'information', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1386, 'ipv4classA', (FALSE), 'ipv4subnetsize(8)', NULL, NULL, 'information', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1387, 'ipv4classB', (FALSE), 'ipv4subnetsize(16)', NULL, NULL, 'information', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1388, 'ipv4classC', (FALSE), 'ipv4subnetsize(24)', NULL, NULL, 'information', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1389, 'woolyarnrun', (FALSE), 'yard/pound', '1600', '1600 yds of "number 1 yarn" weighs', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1390, 'yarncut', (FALSE), 'yard/pound', '300', 'Less common system used in', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1391, 'cottonyarncount', (FALSE), 'yard/pound', '840', NULL, 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1392, 'linenyarncount', (FALSE), 'yard/pound', '300', 'Also used for hemp and ramie', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1393, 'worstedyarncount', (FALSE), 'ft/pound', '1680', NULL, 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1394, 'metricyarncount', (FALSE), 'meter/gram', NULL, NULL, 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1395, 'denier', (FALSE), 'tex', '1|9', 'used for silk and rayon', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1396, 'manchesteryarnnumber', (FALSE), 'yards', 'drams/1000', 'old system used for silk', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1397, 'pli', (FALSE), 'lb/in', NULL, NULL, 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1398, 'typp', (FALSE), 'yd/lb', '1000', 'abbreviation for Thousand Yard Per Pound', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1399, 'asbestoscut', (FALSE), 'yd/lb', '100', 'used for glass and asbestos yarn', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1400, 'drex', (FALSE), 'tex', '0.1', 'to be used for any kind of yarn', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1401, 'skeincotton', (FALSE), 'inch', '80*54', '80 turns of thread on a reel with a', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1402, 'cottonbolt', (FALSE), 'ft', '120', 'cloth measurement', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1403, 'woolbolt', (FALSE), 'ft', '210', NULL, 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1404, 'bolt', (FALSE), 'cottonbolt', NULL, NULL, 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1405, 'heer', (FALSE), 'yards', '600', NULL, 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1406, 'cut', (FALSE), 'yards', '300', 'used for wet-spun linen yarn', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1407, 'lea', (FALSE), 'yards', '300', NULL, 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1408, 'sailmakersyard', (FALSE), 'in', '28.5', NULL, 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1409, 'silkmm', (FALSE), 'silkmomme', NULL, 'But it is also defined as', 'cloth', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1410, 'bloodunit', (FALSE), 'ml', '450', 'For whole blood.  For blood', 'medical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1411, 'frenchcathetersize', (FALSE), 'mm', '1|3', 'measure used for the outer diameter', 'medical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1412, 'charriere', (FALSE), 'frenchcathetersize', NULL, NULL, 'medical', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1413, 'unitedstatesdollar', (FALSE), 'US$', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1414, 'usdollar', (FALSE), 'US$', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1415, '$', (FALSE), 'dollar', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1416, 'mark', (FALSE), 'germanymark', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1417, 'peseta', (FALSE), 'spainpeseta', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1418, 'rand', (FALSE), 'southafricarand', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1419, 'escudo', (FALSE), 'portugalescudo', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1420, 'guilder', (FALSE), 'netherlandsguilder', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1421, 'hollandguilder', (FALSE), 'netherlandsguilder', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1422, 'peso', (FALSE), 'mexicopeso', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1423, 'yen', (FALSE), 'japanyen', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1424, 'lira', (FALSE), 'italylira', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1425, 'rupee', (FALSE), 'indiarupee', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1426, 'drachma', (FALSE), 'greecedrachma', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1427, 'franc', (FALSE), 'francefranc', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1428, 'markka', (FALSE), 'finlandmarkka', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1429, 'britainpound', (FALSE), 'unitedkingdompound', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1430, 'greatbritainpound', (FALSE), 'unitedkingdompound', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1431, 'unitedkingdompound', (FALSE), 'ukpound', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1432, 'poundsterling', (FALSE), 'britainpound', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1433, 'yuan', (FALSE), 'chinayuan', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1434, 'icelandkróna', (FALSE), 'icelandkrona', NULL, NULL, 'currency', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1435, 'polandzłoty', (FALSE), 'polandzloty', NULL, NULL, 'currency', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1436, 'tongapa’anga', (FALSE), 'tongapa''anga', NULL, NULL, 'currency', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1437, 'vietnamđồng', (FALSE), 'vietnamdong', NULL, NULL, 'currency', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1438, 'mongoliatögrög', (FALSE), 'mongoliatugrik', NULL, NULL, 'currency', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1439, 'sãotomé&príncipedobra', (FALSE), 'saotome&principedobra', NULL, NULL, 'currency', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1440, 'UKP', (FALSE), 'GBP', NULL, 'Not an ISO code, but looks like one, and', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1441, 'dollargold', (FALSE), 'newdollargold', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1442, 'goldounce', (FALSE), 'troyounce', 'goldprice', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1443, 'silverounce', (FALSE), 'troyounce', 'silverprice', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1444, 'platinumounce', (FALSE), 'troyounce', 'platinumprice', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1445, 'XAU', (FALSE), 'goldounce', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1446, 'XPT', (FALSE), 'platinumounce', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1447, 'XAG', (FALSE), 'silverounce', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1448, 'USpennyweight', (FALSE), 'grams', '2.5', 'Since 1982, 48 grains before', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1449, 'USnickelweight', (FALSE), 'grams', '5', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1450, 'USdollarweight', (FALSE), 'grams', '8.1', 'Weight of Susan B. Anthony and', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1451, 'quid', (FALSE), 'britainpound', NULL, 'Slang names', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1452, 'fiver', (FALSE), 'quid', '5', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1453, 'tenner', (FALSE), 'quid', '10', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1454, 'monkey', (FALSE), 'quid', '500', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1455, 'brgrand', (FALSE), 'quid', '1000', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1456, 'bob', (FALSE), 'shilling', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1457, 'shilling', (FALSE), 'britainpound', '1|20', 'Before decimalisation, there', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1458, 'oldpence', (FALSE), 'shilling', '1|12', 'were 20 shillings to a pound,', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1459, 'farthing', (FALSE), 'oldpence', '1|4', 'each of twelve old pence', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1460, 'guinea', (FALSE), 'shilling', '21', 'Still used in horse racing', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1461, 'crown', (FALSE), 'shilling', '5', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1462, 'florin', (FALSE), 'shilling', '2', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1463, 'groat', (FALSE), 'oldpence', '4', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1464, 'tanner', (FALSE), 'oldpence', '6', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1465, 'brpenny', (FALSE), 'britainpound', '0.01', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1466, 'pence', (FALSE), 'brpenny', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1467, 'tuppence', (FALSE), 'pence', '2', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1468, 'tuppenny', (FALSE), 'tuppence', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1469, 'ha''penny', (FALSE), 'halfbrpenny', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1470, 'hapenny', (FALSE), 'ha''penny', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1471, 'oldpenny', (FALSE), 'oldpence', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1472, 'oldtuppence', (FALSE), 'oldpence', '2', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1473, 'oldtuppenny', (FALSE), 'oldtuppence', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1474, 'threepence', (FALSE), 'oldpence', '3', 'threepence never refers to new money', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1475, 'threepenny', (FALSE), 'threepence', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1476, 'oldthreepence', (FALSE), 'threepence', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1477, 'oldthreepenny', (FALSE), 'threepence', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1478, 'oldhalfpenny', (FALSE), 'halfoldpenny', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1479, 'oldha''penny', (FALSE), 'oldhalfpenny', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1480, 'oldhapenny', (FALSE), 'oldha''penny', NULL, NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1481, 'brpony', (FALSE), 'britainpound', '25', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1482, 'loony', (FALSE), 'canadadollar', '1', 'This coin depicts a loon', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1483, 'toony', (FALSE), 'canadadollar', '2', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1484, 'satoshi', (FALSE), 'bitcoin', '1e-8', NULL, 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1485, 'XBT', (FALSE), 'bitcoin', NULL, 'nonstandard code', 'currency', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1486, 'cord', (FALSE), 'ft^3', '4*4*8', '4 ft by 4 ft by 8 ft bundle of wood', 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1487, 'facecord', (FALSE), 'cord', '1|2', NULL, 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1488, 'cordfoot', (FALSE), 'cord', '1|8', 'One foot long section of a cord', 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1489, 'cordfeet', (FALSE), 'cordfoot', NULL, NULL, 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1490, 'housecord', (FALSE), 'cord', '1|3', 'Used to sell firewood for residences,', 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1491, 'boardfoot', (FALSE), 'inch', 'ft^2', 'Usually 1 inch thick wood', 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1492, 'boardfeet', (FALSE), 'boardfoot', NULL, NULL, 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1493, 'fbm', (FALSE), 'boardfoot', NULL, 'feet board measure', 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1494, 'stack', (FALSE), 'yard^3', '4', 'British, used for firewood and coal [18]', 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1495, 'stere', (FALSE), 'm^3', NULL, NULL, 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1496, 'timberfoot', (FALSE), 'ft^3', NULL, 'Used for measuring solid blocks of wood', 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1497, 'hoppusfoot', (FALSE), 'ft^3', '(4/pi)', 'Volume calculation suggested in 1736', 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1498, 'hoppusboardfoot', (FALSE), 'hoppusfoot', '1|12', 'forestry manual by Edward Hoppus, for', 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1499, 'hoppuston', (FALSE), 'hoppusfoot', '50', 'estimating the usable volume of a log.', 'wood', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1500, 'hectare', (FALSE), 'hectoare', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1501, 'megohm', (FALSE), 'megaohm', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1502, 'kilohm', (FALSE), 'kiloohm', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1503, 'microhm', (FALSE), 'microohm', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1504, 'megalerg', (FALSE), 'megaerg', NULL, '''L'' added to make it pronounceable [18].', 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1505, 'lbcut', (FALSE), 'poundcut', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1506, 'g00', (FALSE), '(-1)', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1507, 'g000', (FALSE), '(-2)', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1508, 'g0000', (FALSE), '(-3)', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1509, 'g00000', (FALSE), '(-4)', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1510, 'g000000', (FALSE), '(-5)', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1511, 'g0000000', (FALSE), '(-6)', NULL, NULL, 'misc', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1512, 'awg()', (FALSE), 'wiregauge', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1513, 'drillA', (FALSE), 'in', '0.234', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1514, 'drillB', (FALSE), 'in', '0.238', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1515, 'drillC', (FALSE), 'in', '0.242', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1516, 'drillD', (FALSE), 'in', '0.246', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1517, 'drillE', (FALSE), 'in', '0.250', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1518, 'drillF', (FALSE), 'in', '0.257', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1519, 'drillG', (FALSE), 'in', '0.261', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1520, 'drillH', (FALSE), 'in', '0.266', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1521, 'drillI', (FALSE), 'in', '0.272', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1522, 'drillJ', (FALSE), 'in', '0.277', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1523, 'drillK', (FALSE), 'in', '0.281', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1524, 'drillL', (FALSE), 'in', '0.290', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1525, 'drillM', (FALSE), 'in', '0.295', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1526, 'drillN', (FALSE), 'in', '0.302', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1527, 'drillO', (FALSE), 'in', '0.316', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1528, 'drillP', (FALSE), 'in', '0.323', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1529, 'drillQ', (FALSE), 'in', '0.332', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1530, 'drillR', (FALSE), 'in', '0.339', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1531, 'drillS', (FALSE), 'in', '0.348', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1532, 'drillT', (FALSE), 'in', '0.358', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1533, 'drillU', (FALSE), 'in', '0.368', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1534, 'drillV', (FALSE), 'in', '0.377', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1535, 'drillW', (FALSE), 'in', '0.386', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1536, 'drillX', (FALSE), 'in', '0.397', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1537, 'drillY', (FALSE), 'in', '0.404', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1538, 'drillZ', (FALSE), 'in', '0.413', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1539, 'grit_ansibonded()', (FALSE), 'ansibonded', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1540, 'grit_ansicoated()', (FALSE), 'ansicoated', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1541, 'dmtxxcoarse', (FALSE), 'micron', '120', '120 mesh', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1542, 'dmtsilver', (FALSE), 'dmtxxcoarse', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1543, 'dmtxx', (FALSE), 'dmtxxcoarse', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1544, 'dmtxcoarse', (FALSE), 'micron', '60', '220 mesh', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1545, 'dmtx', (FALSE), 'dmtxcoarse', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1546, 'dmtblack', (FALSE), 'dmtxcoarse', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1547, 'dmtcoarse', (FALSE), 'micron', '45', '325 mesh', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1548, 'dmtc', (FALSE), 'dmtcoarse', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1549, 'dmtblue', (FALSE), 'dmtcoarse', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1550, 'dmtfine', (FALSE), 'micron', '25', '600 mesh', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1551, 'dmtred', (FALSE), 'dmtfine', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1552, 'dmtf', (FALSE), 'dmtfine', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1553, 'dmtefine', (FALSE), 'micron', '9', '1200 mesh', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1554, 'dmte', (FALSE), 'dmtefine', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1555, 'dmtgreen', (FALSE), 'dmtefine', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1556, 'dmtceramic', (FALSE), 'micron', '7', '2200 mesh', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1557, 'dmtcer', (FALSE), 'dmtceramic', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1558, 'dmtwhite', (FALSE), 'dmtceramic', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1559, 'dmteefine', (FALSE), 'micron', '3', '8000 mesh', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1560, 'dmttan', (FALSE), 'dmteefine', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1561, 'dmtee', (FALSE), 'dmteefine', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1562, 'hardtranslucentarkansas', (FALSE), 'micron', '6', 'Natural novaculite (silicon quartz)', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1563, 'softarkansas', (FALSE), 'micron', '22', 'stones', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1564, 'extrafineindia', (FALSE), 'micron', '22', 'India stones are Norton''s manufactured', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1565, 'fineindia', (FALSE), 'micron', '35', 'aluminum oxide product', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1566, 'mediumindia', (FALSE), 'micron', '53.5', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1567, 'coarseindia', (FALSE), 'micron', '97', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1568, 'finecrystolon', (FALSE), 'micron', '45', 'Crystolon stones are Norton''s', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1569, 'mediumcrystalon', (FALSE), 'micron', '78', 'manufactured silicon carbide product', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1570, 'coarsecrystalon', (FALSE), 'micron', '127', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1571, 'hardblackarkansas', (FALSE), 'micron', '6', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1572, 'hardwhitearkansas', (FALSE), 'micron', '11', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1573, 'washita', (FALSE), 'micron', '35', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1574, 'meshUS()', (FALSE), 'sieve', NULL, 'were in common usage.', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1575, 'sizeAring', (FALSE), 'mm', '37.50', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1576, 'sizeBring', (FALSE), 'mm', '38.75', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1577, 'sizeCring', (FALSE), 'mm', '40.00', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1578, 'sizeDring', (FALSE), 'mm', '41.25', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1579, 'sizeEring', (FALSE), 'mm', '42.50', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1580, 'sizeFring', (FALSE), 'mm', '43.75', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1581, 'sizeGring', (FALSE), 'mm', '45.00', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1582, 'sizeHring', (FALSE), 'mm', '46.25', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1583, 'sizeIring', (FALSE), 'mm', '47.50', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1584, 'sizeJring', (FALSE), 'mm', '48.75', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1585, 'sizeKring', (FALSE), 'mm', '50.00', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1586, 'sizeLring', (FALSE), 'mm', '51.25', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1587, 'sizeMring', (FALSE), 'mm', '52.50', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1588, 'sizeNring', (FALSE), 'mm', '53.75', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1589, 'sizeOring', (FALSE), 'mm', '55.00', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1590, 'sizePring', (FALSE), 'mm', '56.25', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1591, 'sizeQring', (FALSE), 'mm', '57.50', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1592, 'sizeRring', (FALSE), 'mm', '58.75', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1593, 'sizeSring', (FALSE), 'mm', '60.00', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1594, 'sizeTring', (FALSE), 'mm', '61.25', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1595, 'sizeUring', (FALSE), 'mm', '62.50', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1596, 'sizeVring', (FALSE), 'mm', '63.75', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1597, 'sizeWring', (FALSE), 'mm', '65.00', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1598, 'sizeXring', (FALSE), 'mm', '66.25', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1599, 'sizeYring', (FALSE), 'mm', '67.50', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1600, 'sizeZring', (FALSE), 'mm', '68.75', NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1601, 'pa', (FALSE), 'Pa', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1602, 'ev', (FALSE), 'eV', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1603, 'oe', (FALSE), 'Oe', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1604, 'mh', (FALSE), 'mH', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1605, 'rd', (FALSE), 'rod', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1606, 'pf', (FALSE), 'pF', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1607, 'gr', (FALSE), 'grain', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1608, 'nt', (FALSE), 'N', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1609, 'hz', (FALSE), 'Hz', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1610, 'hd', (FALSE), 'hogshead', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1611, 'dry', (FALSE), 'drygallon/gallon', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1612, 'nmile', (FALSE), 'nauticalmile', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1613, 'beV', (FALSE), 'GeV', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1614, 'bev', (FALSE), 'beV', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1615, 'coul', (FALSE), 'C', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1616, 'Tim', (FALSE), 'hour', '12^-4', 'Time', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1617, 'Grafut', (FALSE), 'Tim^2', 'gravity', 'Length based on gravity', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1618, 'Surf', (FALSE), 'Grafut^2', NULL, 'area', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1619, 'Volm', (FALSE), 'Grafut^3', NULL, 'volume', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1620, 'Vlos', (FALSE), 'Grafut/Tim', NULL, 'speed', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1621, 'Denz', (FALSE), 'Maz/Volm', NULL, 'density', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1622, 'Mag', (FALSE), 'gravity', 'Maz', 'force', 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1623, 'Gf', (FALSE), 'Grafut', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1624, 'Sf', (FALSE), 'Surf', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1625, 'Vm', (FALSE), 'Volm', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1626, 'Vl', (FALSE), 'Vlos', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1627, 'Mz', (FALSE), 'Maz', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1628, 'Dz', (FALSE), 'Denz', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1629, 'Zena-', (FALSE), '12', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1630, 'Duna-', (FALSE), '12^2', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1631, 'Trina-', (FALSE), '12^3', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1632, 'Quedra-', (FALSE), '12^4', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1633, 'Quena-', (FALSE), '12^5', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1634, 'Hesa-', (FALSE), '12^6', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1635, 'Seva-', (FALSE), '12^7', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1636, 'Aka-', (FALSE), '12^8', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1637, 'Neena-', (FALSE), '12^9', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1638, 'Dexa-', (FALSE), '12^10', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1639, 'Lefa-', (FALSE), '12^11', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1640, 'Zennila-', (FALSE), '12^12', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1641, 'Zeni-', (FALSE), '12^-1', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1642, 'Duni-', (FALSE), '12^-2', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1643, 'Trini-', (FALSE), '12^-3', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1644, 'Quedri-', (FALSE), '12^-4', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1645, 'Queni-', (FALSE), '12^-5', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1646, 'Hesi-', (FALSE), '12^-6', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1647, 'Sevi-', (FALSE), '12^-7', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1648, 'Aki-', (FALSE), '12^-8', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1649, 'Neeni-', (FALSE), '12^-9', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1650, 'Dexi-', (FALSE), '12^-10', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1651, 'Lefi-', (FALSE), '12^-11', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1652, 'Zennili-', (FALSE), '12^-12', NULL, NULL, 'misc', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1653, 'cumec', (FALSE), 'm^3/s', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1654, 'cusec', (FALSE), 'ft^3/s', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1655, 'gph', (FALSE), 'gal/hr', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1656, 'gpm', (FALSE), 'gal/min', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1657, 'mgd', (FALSE), 'megagal/day', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1658, 'cfs', (FALSE), 'ft^3/s', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1659, 'cfh', (FALSE), 'ft^3/hour', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1660, 'cfm', (FALSE), 'ft^3/min', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1661, 'lpm', (FALSE), 'liter/min', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1662, 'lfm', (FALSE), 'ft/min', NULL, 'Used to report air flow produced by fans.', 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1663, 'minersinchAZ', (FALSE), 'ft^3/min', '1.5', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1664, 'minersinchCA', (FALSE), 'ft^3/min', '1.5', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1665, 'minersinchMT', (FALSE), 'ft^3/min', '1.5', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1666, 'minersinchNV', (FALSE), 'ft^3/min', '1.5', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1667, 'minersinchOR', (FALSE), 'ft^3/min', '1.5', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1668, 'minersinchID', (FALSE), 'ft^3/min', '1.2', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1669, 'minersinchKS', (FALSE), 'ft^3/min', '1.2', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1670, 'minersinchNE', (FALSE), 'ft^3/min', '1.2', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1671, 'minersinchNM', (FALSE), 'ft^3/min', '1.2', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1672, 'minersinchND', (FALSE), 'ft^3/min', '1.2', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1673, 'minersinchSD', (FALSE), 'ft^3/min', '1.2', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1674, 'minersinchUT', (FALSE), 'ft^3/min', '1.2', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1675, 'minersinchBC', (FALSE), 'ft^3/min', '1.68', 'British Columbia', 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1676, 'GAS_FLOW', (FALSE), 'FLUID_FLOW', 'PRESSURE', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1677, 'sccm', (FALSE), 'cc/min', 'atm', '''s'' is for "standard" to indicate', 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1678, 'sccs', (FALSE), 'cc/sec', 'atm', 'flow at standard pressure', 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1679, 'scfh', (FALSE), 'ft^3/hour', 'atm', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1680, 'scfm', (FALSE), 'ft^3/min', 'atm', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1681, 'slpm', (FALSE), 'liter/min', 'atm', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1682, 'slph', (FALSE), 'liter/hour', 'atm', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1683, 'lapserate', (FALSE), 'K/km', '6.5', 'US Std Atm (1976)', 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1684, 'polyndx', (FALSE), 'polyndx_1976', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1685, 'stdatmT0', (FALSE), 'K', '288.15', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1686, 'stdatmP0', (FALSE), 'atm', NULL, NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1687, 'earthradUSAtm', (FALSE), 'm', '6356766', NULL, 'flow', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1688, 'Patm', (FALSE), 'atm', NULL, NULL, 'flow', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1689, 'msw', (FALSE), 'seawater', 'meter', NULL, 'flow', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1690, 'fsw', (FALSE), 'seawater', 'foot', NULL, 'flow', NULL, 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1691, 'mph', (FALSE), 'mile/hr', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1692, 'mpg', (FALSE), 'mile/gal', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1693, 'kph', (FALSE), 'km/hr', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1694, 'fL', (FALSE), 'footlambert', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1695, 'fpm', (FALSE), 'ft/min', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1696, 'fps', (FALSE), 'ft/s', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1697, 'rpm', (FALSE), 'rev/min', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1698, 'rps', (FALSE), 'rev/sec', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1699, 'mi', (FALSE), 'mile', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1700, 'smi', (FALSE), 'mile', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1702, 'mbh', (FALSE), 'btu/hour', '1e3', NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1703, 'mcm', (FALSE), 'circularmil', '1e3', NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1704, 'ipy', (FALSE), 'inch/year', NULL, 'used for corrosion rates', 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1705, 'ccf', (FALSE), 'ft^3', '100', 'used for selling water [18]', 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1706, 'Mcf', (FALSE), 'ft^3', '1000', 'not million cubic feet [18]', 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1707, 'kp', (FALSE), 'kilopond', NULL, NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1708, 'kpm', (FALSE), 'meter', 'kp', NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1709, 'Wh', (FALSE), 'hour', 'W', NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1710, 'hph', (FALSE), 'hour', 'hp', NULL, 'abbrev', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1711, 'becquerel', (FALSE), '/s', NULL, 'Activity of radioactive source', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1712, 'Bq', (FALSE), 'becquerel', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1713, 'curie', (FALSE), 'Bq', '3.7e10', 'Defined in 1910 as the radioactivity', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1714, 'Ci', (FALSE), 'curie', NULL, 'emitted by the amount of radon that is', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1715, 'rutherford', (FALSE), 'Bq', '1e6', NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1716, 'RADIATION_DOSE', (FALSE), 'gray', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1717, 'gray', (FALSE), 'J/kg', NULL, 'Absorbed dose of radiation', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1718, 'Gy', (FALSE), 'gray', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1719, 'rad', (FALSE), 'Gy', '1e-2', 'From Radiation Absorbed Dose', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1720, 'rep', (FALSE), 'mGy', '8.38', 'Roentgen Equivalent Physical, the amount', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1721, 'sievert', (FALSE), 'J/kg', NULL, 'Dose equivalent:  dosage that has the', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1722, 'Sv', (FALSE), 'sievert', NULL, 'same effect on human tissues as 200', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1723, 'rem', (FALSE), 'Sv', '1e-2', 'keV X-rays.  Different types of', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1724, 'banana_dose', (FALSE), 'sievert', '0.1e-6', 'Informal measure of the dose due to', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1725, 'rontgen', (FALSE), 'roentgen', NULL, 'Sometimes it appears spelled this way', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1726, 'sievertunit', (FALSE), 'rontgen', '8.38', 'Unit of gamma ray dose delivered in one', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1727, 'eman', (FALSE), 'Ci/m^3', '1e-7', 'radioactive concentration', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1728, 'mache', (FALSE), 'Ci/m^3', '3.7e-7', NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1729, 'actinium', (FALSE), '227.0278', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1730, 'aluminum', (FALSE), '26.981539', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1731, 'americium', (FALSE), '243.0614', NULL, 'Longest lived. 241.06', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1732, 'antimony', (FALSE), '121.760', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1733, 'argon', (FALSE), '39.948', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1734, 'arsenic', (FALSE), '74.92159', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1735, 'astatine', (FALSE), '209.9871', NULL, 'Longest lived', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1736, 'barium', (FALSE), '137.327', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1737, 'berkelium', (FALSE), '247.0703', NULL, 'Longest lived. 249.08', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1738, 'beryllium', (FALSE), '9.012182', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1739, 'bismuth', (FALSE), '208.98037', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1740, 'boron', (FALSE), '10.811', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1741, 'bromine', (FALSE), '79.904', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1742, 'cadmium', (FALSE), '112.411', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1743, 'calcium', (FALSE), '40.078', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1744, 'californium', (FALSE), '251.0796', NULL, 'Longest lived.  252.08', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1745, 'carbon', (FALSE), '12.011', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1746, 'cerium', (FALSE), '140.115', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1747, 'cesium', (FALSE), '132.90543', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1748, 'chlorine', (FALSE), '35.4527', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1749, 'chromium', (FALSE), '51.9961', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1750, 'cobalt', (FALSE), '58.93320', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1751, 'copper', (FALSE), '63.546', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1752, 'curium', (FALSE), '247.0703', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1753, 'deuterium', (FALSE), '2.0141017778', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1754, 'dysprosium', (FALSE), '162.50', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1755, 'einsteinium', (FALSE), '252.083', NULL, 'Longest lived', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1756, 'erbium', (FALSE), '167.26', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1757, 'europium', (FALSE), '151.965', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1758, 'fermium', (FALSE), '257.0951', NULL, 'Longest lived', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1759, 'fluorine', (FALSE), '18.9984032', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1760, 'francium', (FALSE), '223.0197', NULL, 'Longest lived', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1761, 'gadolinium', (FALSE), '157.25', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1762, 'gallium', (FALSE), '69.723', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1763, 'germanium', (FALSE), '72.61', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1764, 'gold', (FALSE), '196.96654', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1765, 'hafnium', (FALSE), '178.49', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1766, 'helium', (FALSE), '4.002602', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1767, 'holmium', (FALSE), '164.93032', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1768, 'hydrogen', (FALSE), '1.00794', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1769, 'indium', (FALSE), '114.818', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1770, 'iodine', (FALSE), '126.90447', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1771, 'iridium', (FALSE), '192.217', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1772, 'iron', (FALSE), '55.845', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1773, 'krypton', (FALSE), '83.80', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1774, 'lanthanum', (FALSE), '138.9055', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1775, 'lawrencium', (FALSE), '262.11', NULL, 'Longest lived', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1776, 'lead', (FALSE), '207.2', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1777, 'lithium', (FALSE), '6.941', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1778, 'lutetium', (FALSE), '174.967', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1779, 'magnesium', (FALSE), '24.3050', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1780, 'manganese', (FALSE), '54.93805', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1781, 'mendelevium', (FALSE), '258.10', NULL, 'Longest lived', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1782, 'mercury', (FALSE), '200.59', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1783, 'molybdenum', (FALSE), '95.94', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1784, 'neodymium', (FALSE), '144.24', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1785, 'neon', (FALSE), '20.1797', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1786, 'neptunium', (FALSE), '237.0482', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1787, 'nickel', (FALSE), '58.6934', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1788, 'niobium', (FALSE), '92.90638', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1789, 'nitrogen', (FALSE), '14.00674', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1790, 'nobelium', (FALSE), '259.1009', NULL, 'Longest lived', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1791, 'osmium', (FALSE), '190.23', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1792, 'oxygen', (FALSE), '15.9994', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1793, 'palladium', (FALSE), '106.42', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1794, 'phosphorus', (FALSE), '30.973762', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1795, 'platinum', (FALSE), '195.08', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1796, 'plutonium', (FALSE), '244.0642', NULL, 'Longest lived.  239.05', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1797, 'polonium', (FALSE), '208.9824', NULL, 'Longest lived.  209.98', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1798, 'potassium', (FALSE), '39.0983', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1799, 'praseodymium', (FALSE), '140.90765', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1800, 'promethium', (FALSE), '144.9127', NULL, 'Longest lived.  146.92', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1801, 'protactinium', (FALSE), '231.03588', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1802, 'radium', (FALSE), '226.0254', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2106, '⅙-', (FALSE), '1|6', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1803, 'radon', (FALSE), '222.0176', NULL, 'Longest lived', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1804, 'rhenium', (FALSE), '186.207', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1805, 'rhodium', (FALSE), '102.90550', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1806, 'rubidium', (FALSE), '85.4678', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1807, 'ruthenium', (FALSE), '101.07', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1808, 'samarium', (FALSE), '150.36', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1809, 'scandium', (FALSE), '44.955910', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1810, 'selenium', (FALSE), '78.96', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1811, 'silicon', (FALSE), '28.0855', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1812, 'silver', (FALSE), '107.8682', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1813, 'sodium', (FALSE), '22.989768', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1814, 'strontium', (FALSE), '87.62', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1815, 'sulfur', (FALSE), '32.066', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1816, 'tantalum', (FALSE), '180.9479', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1817, 'technetium', (FALSE), '97.9072', NULL, 'Longest lived.  98.906', 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1818, 'tellurium', (FALSE), '127.60', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1819, 'terbium', (FALSE), '158.92534', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1820, 'thallium', (FALSE), '204.3833', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1821, 'thorium', (FALSE), '232.0381', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1822, 'thullium', (FALSE), '168.93421', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1823, 'tin', (FALSE), '118.710', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1824, 'titanium', (FALSE), '47.867', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1825, 'tungsten', (FALSE), '183.84', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1826, 'uranium', (FALSE), '238.0289', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1827, 'vanadium', (FALSE), '50.9415', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1828, 'xenon', (FALSE), '131.29', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1829, 'ytterbium', (FALSE), '173.04', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1830, 'yttrium', (FALSE), '88.90585', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1831, 'zinc', (FALSE), '65.39', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1832, 'zirconium', (FALSE), '91.224', NULL, NULL, 'radioactive', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1833, 'people', (FALSE), '1', NULL, NULL, 'people', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1834, 'person', (FALSE), 'people', NULL, NULL, 'people', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1835, 'death', (FALSE), 'people', NULL, NULL, 'people', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1836, 'capita', (FALSE), 'people', NULL, NULL, 'people', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1837, 'percapita', (FALSE), 'capita', 'per', NULL, 'people', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1838, 'scotsinch', (FALSE), 'UKinch', '1.00540054', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1839, 'scotslink', (FALSE), 'scotschain', '1|100', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1840, 'scotsfoot', (FALSE), 'scotsinch', '12', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1841, 'scotsfeet', (FALSE), 'scotsfoot', NULL, NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1842, 'scotsell', (FALSE), 'scotsinch', '37', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1843, 'scotsfall', (FALSE), 'scotsell', '6', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1844, 'scotschain', (FALSE), 'scotsfall', '4', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1845, 'scotsfurlong', (FALSE), 'scotschain', '10', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1846, 'scotsmile', (FALSE), 'scotsfurlong', '8', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1847, 'scotsrood', (FALSE), 'scotsfall^2', '40', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1848, 'scotsacre', (FALSE), 'scotsrood', '4', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1849, 'scotsgill', (FALSE), 'mutchkin', '1|4', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1850, 'mutchkin', (FALSE), 'choppin', '1|2', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1851, 'choppin', (FALSE), 'scotspint', '1|2', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1852, 'scotspint', (FALSE), 'scotsquart', '1|2', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1853, 'scotsquart', (FALSE), 'scotsgallon', '1|4', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1854, 'scotsgallon', (FALSE), 'UKinch^3', '827.232', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1855, 'scotsbarrel', (FALSE), 'scotsgallon', '8', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1856, 'jug', (FALSE), 'scotspint', NULL, NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1857, 'scotswheatlippy', (FALSE), 'UKinch^3', '137.333', 'Also used for peas, beans, rye, salt', 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1858, 'scotswheatlippies', (FALSE), 'scotswheatlippy', NULL, NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1859, 'scotswheatpeck', (FALSE), 'scotswheatlippy', '4', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1860, 'scotswheatfirlot', (FALSE), 'scotswheatpeck', '4', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1861, 'scotswheatboll', (FALSE), 'scotswheatfirlot', '4', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1862, 'scotswheatchalder', (FALSE), 'scotswheatboll', '16', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1863, 'scotsoatlippy', (FALSE), 'UKinch^3', '200.345', 'Also used for barley and malt', 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1864, 'scotsoatlippies', (FALSE), 'scotsoatlippy', NULL, NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1865, 'scotsoatpeck', (FALSE), 'scotsoatlippy', '4', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1866, 'scotsoatfirlot', (FALSE), 'scotsoatpeck', '4', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1867, 'scotsoatboll', (FALSE), 'scotsoatfirlot', '4', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1868, 'scotsoatchalder', (FALSE), 'scotsoatboll', '16', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1869, 'trondrop', (FALSE), 'tronounce', '1|16', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1870, 'tronounce', (FALSE), 'tronpound', '1|20', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1871, 'tronpound', (FALSE), 'grain', '9520', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1872, 'tronstone', (FALSE), 'tronpound', '16', NULL, 'scots', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1873, 'verklinje', (FALSE), 'mm', '2.0618125', NULL, 'swedish', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1874, 'verktum', (FALSE), 'verklinje', '12', NULL, 'swedish', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1875, 'kvarter', (FALSE), 'verktum', '6', NULL, 'swedish', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1876, 'fot', (FALSE), 'kvarter', '2', NULL, 'swedish', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1877, 'aln', (FALSE), 'fot', '2', NULL, 'swedish', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1878, 'famn', (FALSE), 'aln', '3', NULL, 'swedish', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1879, 'zentner', (FALSE), 'kg', '50', NULL, 'german', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1880, 'doppelzentner', (FALSE), 'zentner', '2', NULL, 'german', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1881, 'pfund', (FALSE), 'g', '500', NULL, 'german', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1882, 'australiasquare', (FALSE), 'ft)^2', '(10', 'Used for house area', 'australian', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1883, 'winepint', (FALSE), 'winequart', '1|2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1884, 'winequart', (FALSE), 'winegallon', '1|4', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1885, 'winegallon', (FALSE), 'UKinch^3', '231', 'Sometimes called the Winchester Wine Gallon,', 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1886, 'winerundlet', (FALSE), 'winegallon', '18', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1887, 'winebarrel', (FALSE), 'winegallon', '31.5', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1888, 'winetierce', (FALSE), 'winegallon', '42', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1889, 'winehogshead', (FALSE), 'winebarrel', '2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1890, 'winepuncheon', (FALSE), 'winetierce', '2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1891, 'winebutt', (FALSE), 'winehogshead', '2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1892, 'winepipe', (FALSE), 'winebutt', NULL, NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1893, 'winetun', (FALSE), 'winebutt', '2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1894, 'beerpint', (FALSE), 'beerquart', '1|2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1895, 'beerquart', (FALSE), 'beergallon', '1|4', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1896, 'beergallon', (FALSE), 'UKinch^3', '282', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1897, 'beerbarrel', (FALSE), 'beergallon', '36', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1898, 'beerhogshead', (FALSE), 'beerbarrel', '1.5', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1899, 'alepint', (FALSE), 'alequart', '1|2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1900, 'alequart', (FALSE), 'alegallon', '1|4', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1901, 'alegallon', (FALSE), 'beergallon', NULL, NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1902, 'alebarrel', (FALSE), 'alegallon', '34', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1903, 'alehogshead', (FALSE), 'alebarrel', '1.5', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1904, 'towerpound', (FALSE), 'grain', '5400', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1905, 'towerounce', (FALSE), 'towerpound', '1|12', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1906, 'towerpennyweight', (FALSE), 'towerounce', '1|20', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1907, 'towergrain', (FALSE), 'towerpennyweight', '1|32', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1908, 'mercpound', (FALSE), 'grain', '6750', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1909, 'mercounce', (FALSE), 'mercpound', '1|15', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1910, 'mercpennyweight', (FALSE), 'mercounce', '1|20', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1911, 'leadstone', (FALSE), 'lb', '12.5', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1912, 'fotmal', (FALSE), 'lb', '70', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1913, 'leadwey', (FALSE), 'leadstone', '14', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1914, 'fothers', (FALSE), 'leadwey', '12', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1915, 'newhaytruss', (FALSE), 'lb', '60', 'New and old here seem to refer to "new"', 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1916, 'newhayload', (FALSE), 'newhaytruss', '36', 'hay and "old" hay rather than a new unit', 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1917, 'oldhaytruss', (FALSE), 'lb', '56', 'and an old unit.', 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1918, 'oldhayload', (FALSE), 'oldhaytruss', '36', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1919, 'woolclove', (FALSE), 'lb', '7', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1920, 'woolstone', (FALSE), 'woolclove', '2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1921, 'wooltod', (FALSE), 'woolstone', '2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1922, 'woolwey', (FALSE), 'woolstone', '13', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1923, 'woolsack', (FALSE), 'woolwey', '2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1924, 'woolsarpler', (FALSE), 'woolsack', '2', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1925, 'woollast', (FALSE), 'woolsarpler', '6', NULL, 'english', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1926, 'romanfoot', (FALSE), 'mm', '296', 'There is some uncertainty in this definition', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1927, 'romanfeet', (FALSE), 'romanfoot', NULL, 'from which all the other units are derived.', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1928, 'pes', (FALSE), 'romanfoot', NULL, 'This value appears in numerous sources. In "The', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1929, 'pedes', (FALSE), 'romanfoot', NULL, 'Roman Land Surveyors", Dilke gives 295.7 mm.', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1930, 'romaninch', (FALSE), 'romanfoot', '1|12', 'The subdivisions of the Roman foot have the', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1931, 'romandigit', (FALSE), 'romanfoot', '1|16', 'same names as the subdivisions of the pound,', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1932, 'romanpalm', (FALSE), 'romanfoot', '1|4', 'but we can''t have the names for different', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1933, 'romancubit', (FALSE), 'romaninch', '18', 'units.', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1934, 'romanpace', (FALSE), 'romanfeet', '5', 'Roman double pace (basic military unit)', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1935, 'passus', (FALSE), 'romanpace', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1936, 'romanperch', (FALSE), 'romanfeet', '10', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1937, 'stade', (FALSE), 'romanpaces', '125', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1938, 'stadia', (FALSE), 'stade', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1939, 'stadium', (FALSE), 'stade', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1940, 'romanmile', (FALSE), 'stadia', '8', '1000 paces', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1941, 'romanleague', (FALSE), 'romanmile', '1.5', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1942, 'schoenus', (FALSE), 'romanmile', '4', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1943, 'earlyromanfoot', (FALSE), 'cm', '29.73', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1944, 'pesdrusianus', (FALSE), 'cm', '33.3', 'or 33.35 cm, used in Gaul & Germany in 1st c BC', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1945, 'lateromanfoot', (FALSE), 'cm', '29.42', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1946, 'actuslength', (FALSE), 'romanfeet', '120', 'length of a Roman furrow', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1947, 'actus', (FALSE), 'romanfeet^2', '120*4', 'area of the furrow', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1948, 'squareactus', (FALSE), 'romanfeet^2', '120^2', 'actus quadratus', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1949, 'acnua', (FALSE), 'squareactus', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1950, 'iugerum', (FALSE), 'squareactus', '2', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1951, 'iugera', (FALSE), 'iugerum', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1952, 'jugerum', (FALSE), 'iugerum', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1953, 'jugera', (FALSE), 'iugerum', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1954, 'heredium', (FALSE), 'iugera', '2', 'heritable plot', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1955, 'heredia', (FALSE), 'heredium', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1956, 'centuria', (FALSE), 'heredia', '100', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1957, 'centurium', (FALSE), 'centuria', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1958, 'sextarius', (FALSE), 'in^3', '35.4', 'Basic unit of Roman volume.  As always,', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1959, 'sextarii', (FALSE), 'sextarius', NULL, 'there is uncertainty.  Six large Roman', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1960, 'cochlearia', (FALSE), 'sextarius', '1|48', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1961, 'cyathi', (FALSE), 'sextarius', '1|12', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1962, 'acetabula', (FALSE), 'sextarius', '1|8', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1963, 'quartaria', (FALSE), 'sextarius', '1|4', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1964, 'quartarius', (FALSE), 'quartaria', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1965, 'heminae', (FALSE), 'sextarius', '1|2', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1966, 'hemina', (FALSE), 'heminae', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1967, 'cheonix', (FALSE), 'sextarii', '1.5', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1968, 'semodius', (FALSE), 'sextarius', '8', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1969, 'semodii', (FALSE), 'semodius', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1970, 'modius', (FALSE), 'sextarius', '16', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1971, 'modii', (FALSE), 'modius', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1972, 'congius', (FALSE), 'heminae', '12', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1973, 'congii', (FALSE), 'congius', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1974, 'amphora', (FALSE), 'congii', '8', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1975, 'amphorae', (FALSE), 'amphora', NULL, 'Also a dry volume measure', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1976, 'culleus', (FALSE), 'amphorae', '20', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1977, 'quadrantal', (FALSE), 'amphora', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1978, 'libra', (FALSE), 'grain', '5052', 'The Roman pound varied significantly', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1979, 'librae', (FALSE), 'libra', NULL, 'from 4210 grains to 5232 grains.  Most of', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1980, 'romanpound', (FALSE), 'libra', NULL, 'the standards were obtained from the weight', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1981, 'uncia', (FALSE), 'libra', '1|12', 'of particular coins.  The one given here is', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1982, 'unciae', (FALSE), 'uncia', NULL, 'based on the Gold Aureus of Augustus which', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1983, 'romanounce', (FALSE), 'uncia', NULL, 'was in use from BC 27 to AD 296.', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1984, 'deunx', (FALSE), 'uncia', '11', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1985, 'dextans', (FALSE), 'uncia', '10', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1986, 'dodrans', (FALSE), 'uncia', '9', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1987, 'bes', (FALSE), 'uncia', '8', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1988, 'seprunx', (FALSE), 'uncia', '7', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1989, 'semis', (FALSE), 'uncia', '6', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1990, 'quincunx', (FALSE), 'uncia', '5', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1991, 'triens', (FALSE), 'uncia', '4', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1992, 'quadrans', (FALSE), 'uncia', '3', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1993, 'sextans', (FALSE), 'uncia', '2', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1994, 'sescuncia', (FALSE), 'uncia', '1.5', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1995, 'semuncia', (FALSE), 'uncia', '1|2', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1996, 'siscilius', (FALSE), 'uncia', '1|4', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1997, 'sextula', (FALSE), 'uncia', '1|6', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1998, 'semisextula', (FALSE), 'uncia', '1|12', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (1999, 'scriptulum', (FALSE), 'uncia', '1|24', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2000, 'scrupula', (FALSE), 'scriptulum', NULL, NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2001, 'romanobol', (FALSE), 'scrupula', '1|2', NULL, 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2002, 'romanaspound', (FALSE), 'grain', '4210', 'Old pound based on bronze coinage, the', 'roman', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2003, 'egyptianroyalcubit', (FALSE), 'in', '20.63', 'plus or minus .2 in', 'egyptian', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2004, 'egyptianpalm', (FALSE), 'egyptianroyalcubit', '1|7', NULL, 'egyptian', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2005, 'egyptiandigit', (FALSE), 'egyptianpalm', '1|4', NULL, 'egyptian', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2006, 'egyptianshortcubit', (FALSE), 'egyptianpalm', '6', NULL, 'egyptian', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2007, 'doubleremen', (FALSE), 'in', '29.16', 'Length of the diagonal of a square with', 'egyptian', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2107, '⅓-', (FALSE), '1|3', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2008, 'remendigit', (FALSE), 'doubleremen', '1|40', 'side length of 1 royal egyptian cubit.', 'egyptian', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2009, 'greekfoot', (FALSE), 'in', '12.45', 'Listed as being derived from the', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2010, 'greekfeet', (FALSE), 'greekfoot', NULL, 'Egyptian Royal cubit in [11].  It is', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2011, 'greekcubit', (FALSE), 'greekfoot', '1.5', 'said to be 3|5 of a 20.75 in cubit.', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2012, 'pous', (FALSE), 'greekfoot', NULL, NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2013, 'podes', (FALSE), 'greekfoot', NULL, NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2014, 'orguia', (FALSE), 'greekfoot', '6', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2015, 'greekfathom', (FALSE), 'orguia', NULL, NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2016, 'stadion', (FALSE), 'orguia', '100', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2017, 'akaina', (FALSE), 'greekfeet', '10', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2018, 'plethron', (FALSE), 'akaina', '10', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2019, 'greekfinger', (FALSE), 'greekfoot', '1|16', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2020, 'homericcubit', (FALSE), 'greekfingers', '20', 'Elbow to end of knuckles.', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2021, 'shortgreekcubit', (FALSE), 'greekfingers', '18', 'Elbow to start of fingers.', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2022, 'ionicfoot', (FALSE), 'mm', '296', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2023, 'doricfoot', (FALSE), 'mm', '326', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2024, 'olympiccubit', (FALSE), 'remendigit', '25', 'These olympic measures were not as', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2025, 'olympicfoot', (FALSE), 'olympiccubit', '2|3', 'common as the other greek measures.', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2026, 'olympicfinger', (FALSE), 'olympicfoot', '1|16', 'They were used in agriculture.', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2027, 'olympicfeet', (FALSE), 'olympicfoot', NULL, NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2028, 'olympicdakylos', (FALSE), 'olympicfinger', NULL, NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2029, 'olympicpalm', (FALSE), 'olympicfoot', '1|4', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2030, 'olympicpalestra', (FALSE), 'olympicpalm', NULL, NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2031, 'olympicspithame', (FALSE), 'foot', '3|4', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2032, 'olympicspan', (FALSE), 'olympicspithame', NULL, NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2033, 'olympicbema', (FALSE), 'olympicfeet', '2.5', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2034, 'olympicpace', (FALSE), 'olympicbema', NULL, NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2035, 'olympicorguia', (FALSE), 'olympicfeet', '6', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2036, 'olympicfathom', (FALSE), 'olympicorguia', NULL, NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2037, 'olympiccord', (FALSE), 'olympicfeet', '60', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2038, 'olympicamma', (FALSE), 'olympiccord', NULL, NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2039, 'olympicplethron', (FALSE), 'olympicfeet', '100', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2040, 'olympicstadion', (FALSE), 'olympicfeet', '600', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2041, 'greekkotyle', (FALSE), 'ml', '270', 'This approximate value is obtained', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2042, 'xestes', (FALSE), 'greekkotyle', '2', 'from two earthenware vessels that', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2043, 'khous', (FALSE), 'greekkotyle', '12', 'were reconstructed from fragments.', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2044, 'metretes', (FALSE), 'khous', '12', 'The kotyle is a day''s corn ration', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2045, 'choinix', (FALSE), 'greekkotyle', '4', 'for one man.', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2046, 'hekteos', (FALSE), 'choinix', '8', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2047, 'medimnos', (FALSE), 'hekteos', '6', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2048, 'aeginastater', (FALSE), 'grain', '192', 'Varies up to 199 grain', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2049, 'aeginadrachmae', (FALSE), 'aeginastater', '1|2', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2050, 'aeginaobol', (FALSE), 'aeginadrachmae', '1|6', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2051, 'aeginamina', (FALSE), 'aeginastaters', '50', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2052, 'aeginatalent', (FALSE), 'aeginamina', '60', 'Supposedly the mass of a cubic foot', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2053, 'atticstater', (FALSE), 'grain', '135', 'Varies 134-138 grain', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2054, 'atticdrachmae', (FALSE), 'atticstater', '1|2', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2055, 'atticobol', (FALSE), 'atticdrachmae', '1|6', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2056, 'atticmina', (FALSE), 'atticstaters', '50', NULL, 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2057, 'attictalent', (FALSE), 'atticmina', '60', 'Supposedly the mass of a cubic foot', 'greek', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2058, 'northerncubit', (FALSE), 'in', '26.6', 'plus/minus .2 in', 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2059, 'northernfoot', (FALSE), 'northerncubit', '1|2', NULL, 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2060, 'sumeriancubit', (FALSE), 'mm', '495', NULL, 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2061, 'kus', (FALSE), 'sumeriancubit', NULL, NULL, 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2062, 'sumerianfoot', (FALSE), 'sumeriancubit', '2|3', NULL, 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2063, 'assyriancubit', (FALSE), 'in', '21.6', NULL, 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2064, 'assyrianfoot', (FALSE), 'assyriancubit', '1|2', NULL, 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2065, 'assyrianpalm', (FALSE), 'assyrianfoot', '1|3', NULL, 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2066, 'assyriansusi', (FALSE), 'assyrianpalm', '1|20', NULL, 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2067, 'susi', (FALSE), 'assyriansusi', NULL, NULL, 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2068, 'persianroyalcubit', (FALSE), 'assyrianpalm', '7', NULL, 'northern', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2069, 'hashimicubit', (FALSE), 'in', '25.56', 'Standard of linear measure used', 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2070, 'blackcubit', (FALSE), 'in', '21.28', NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2071, 'arabicfeet', (FALSE), 'blackcubit', '1|2', NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2072, 'arabicfoot', (FALSE), 'arabicfeet', NULL, NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2073, 'arabicinch', (FALSE), 'arabicfoot', '1|12', NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2074, 'arabicmile', (FALSE), 'blackcubit', '4000', NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2075, 'silverdirhem', (FALSE), 'grain', '45', 'The weights were derived from these two', 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2076, 'tradedirhem', (FALSE), 'grain', '48', 'units with two identically named systems', 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2077, 'silverkirat', (FALSE), 'silverdirhem', '1|16', NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2078, 'silverwukiyeh', (FALSE), 'silverdirhem', '10', NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2079, 'silverrotl', (FALSE), 'silverwukiyeh', '12', NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2080, 'arabicsilverpound', (FALSE), 'silverrotl', NULL, NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2081, 'tradekirat', (FALSE), 'tradedirhem', '1|16', NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2082, 'tradewukiyeh', (FALSE), 'tradedirhem', '10', NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2083, 'traderotl', (FALSE), 'tradewukiyeh', '12', NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2084, 'arabictradepound', (FALSE), 'traderotl', NULL, NULL, 'arabic', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2085, 'timepoint', (FALSE), 'hour', '1|5', 'also given as 1|4', 'medieval', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2086, 'timeminute', (FALSE), 'hour', '1|10', NULL, 'medieval', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2087, 'timeostent', (FALSE), 'hour', '1|60', NULL, 'medieval', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2088, 'timeounce', (FALSE), 'timeostent', '1|8', NULL, 'medieval', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2089, 'timeatom', (FALSE), 'timeounce', '1|47', NULL, 'medieval', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2090, 'mite', (FALSE), 'grain', '1|20', NULL, 'medieval', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2091, 'droit', (FALSE), 'mite', '1|24', NULL, 'medieval', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2092, 'periot', (FALSE), 'droit', '1|20', NULL, 'medieval', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2093, 'blanc', (FALSE), 'periot', '1|24', NULL, 'medieval', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2094, 'parasang', (FALSE), 'mile', '3.5', 'Persian unit of length usually thought', 'ancient', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2095, 'biblicalcubit', (FALSE), 'in', '21.8', NULL, 'ancient', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2096, 'hebrewcubit', (FALSE), 'in', '17.58', NULL, 'ancient', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2097, 'li', (FALSE), 'mile', '10|27.8', 'Chinese unit of length', 'ancient', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2098, 'liang', (FALSE), 'oz', '11|3', 'Chinese weight unit', 'ancient', NULL, NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2099, '⅛-', (FALSE), '1|8', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2100, '¼-', (FALSE), '1|4', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2101, '⅜-', (FALSE), '3|8', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2102, '½-', (FALSE), '1|2', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2103, '⅝-', (FALSE), '5|8', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2104, '¾-', (FALSE), '3|4', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2105, '⅞-', (FALSE), '7|8', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2108, '⅔-', (FALSE), '2|3', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2109, '⅚-', (FALSE), '5|6', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2110, '⅕-', (FALSE), '1|5', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2111, '⅖-', (FALSE), '2|5', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2112, '⅗-', (FALSE), '3|5', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2113, '⅘-', (FALSE), '4|5', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2114, 'ℯ', (FALSE), 'exp(1)', NULL, 'U+212F, base of natural log', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2115, 'µ-', (FALSE), 'micro', NULL, 'micro sign U+00B5', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2116, 'μ-', (FALSE), 'micro', NULL, 'small mu U+03BC', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2117, 'ångström', (FALSE), 'angstrom', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2118, 'Å', (FALSE), 'angstrom', NULL, 'angstrom symbol U+212B', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2119, 'Å', (FALSE), 'angstrom', NULL, 'A with ring U+00C5', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2120, 'röntgen', (FALSE), 'roentgen', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2121, '°C', (FALSE), 'degC', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2122, '°F', (FALSE), 'degF', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2123, '°K', (FALSE), 'K', NULL, '°K is incorrect notation', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2124, '°R', (FALSE), 'degR', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2125, '°', (FALSE), 'degree', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2126, '℃', (FALSE), 'degC', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2127, '℉', (FALSE), 'degF', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2128, 'K', (FALSE), 'K', NULL, 'Kelvin symbol, U+212A', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2129, 'ℓ', (FALSE), 'liter', NULL, 'unofficial abbreviation used in some places', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2130, 'Ω', (FALSE), 'ohm', NULL, 'Ohm symbol U+2126', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2131, 'Ω', (FALSE), 'ohm', NULL, 'Greek capital omega U+03A9', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2132, '℧', (FALSE), 'mho', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2133, 'ʒ', (FALSE), 'dram', NULL, 'U+0292', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2134, '℈', (FALSE), 'scruple', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2135, '℥', (FALSE), 'ounce', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2136, '℔', (FALSE), 'lb', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2137, 'ℎ', (FALSE), 'hplanck', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2138, 'ℏ', (FALSE), 'hbar', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2139, '‰', (FALSE), '1|1000', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2140, '‱', (FALSE), '1|10000', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2141, '′', (FALSE), '''', NULL, 'U+2032', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2142, '″', (FALSE), '"', NULL, 'U+2033', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2143, '¢', (FALSE), 'cent', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2144, '£', (FALSE), 'britainpound', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2145, '¥', (FALSE), 'japanyen', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2146, '€', (FALSE), 'euro', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2147, '₩', (FALSE), 'southkoreawon', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2148, '₪', (FALSE), 'israelnewshekel', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2149, '₤', (FALSE), 'lira', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2150, '₨', (FALSE), 'rupee', NULL, 'unofficial legacy rupee sign', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2151, '฿', (FALSE), 'thailandbaht', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2152, '₡', (FALSE), 'elsalvadorcolon', NULL, 'Also costaricacolon', 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2153, '₣', (FALSE), 'francefranc', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2154, '₦', (FALSE), 'nigerianaira', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2155, '₧', (FALSE), 'spainpeseta', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2156, '₫', (FALSE), 'vietnamdong', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2157, '₭', (FALSE), 'laokip', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2158, '₮', (FALSE), 'mongoliatugrik', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2159, '₯', (FALSE), 'greecedrachma', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2160, '₱', (FALSE), 'philippinepeso', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2161, '﷼', (FALSE), 'iranrial', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2162, '﹩', (FALSE), '$', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2163, '￠', (FALSE), '¢', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2164, '￡', (FALSE), '£', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2165, '￥', (FALSE), '¥', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2166, '￦', (FALSE), '₩', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2167, '㍱', (FALSE), 'hPa', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2168, '㍲', (FALSE), 'da', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2169, '㍳', (FALSE), 'au', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2170, '㍴', (FALSE), 'bar', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2171, '㍶', (FALSE), 'pc', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2172, '㎀', (FALSE), 'pA', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2173, '㎁', (FALSE), 'nA', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2174, '㎂', (FALSE), 'µA', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2175, '㎃', (FALSE), 'mA', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2176, '㎄', (FALSE), 'kA', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2177, '㎅', (FALSE), 'kB', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2178, '㎆', (FALSE), 'MB', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2179, '㎇', (FALSE), 'GB', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2180, '㎈', (FALSE), 'cal', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2181, '㎉', (FALSE), 'kcal', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2182, '㎊', (FALSE), 'pF', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2183, '㎋', (FALSE), 'nF', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2184, '㎌', (FALSE), 'µF', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2185, '㎍', (FALSE), 'µg', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2186, '㎎', (FALSE), 'mg', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2187, '㎏', (FALSE), 'kg', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2188, '㎐', (FALSE), 'Hz', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2189, '㎑', (FALSE), 'kHz', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2190, '㎒', (FALSE), 'MHz', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2191, '㎓', (FALSE), 'GHz', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2192, '㎔', (FALSE), 'THz', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2193, '㎕', (FALSE), 'µL', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2194, '㎖', (FALSE), 'mL', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2195, '㎗', (FALSE), 'dL', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2196, '㎘', (FALSE), 'kL', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2197, '㎙', (FALSE), 'fm', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2198, '㎚', (FALSE), 'nm', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2199, '㎛', (FALSE), 'µm', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2200, '㎜', (FALSE), 'mm', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2201, '㎝', (FALSE), 'cm', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2202, '㎞', (FALSE), 'km', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2203, '㎟', (FALSE), 'mm^2', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2204, '㎠', (FALSE), 'cm^2', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2205, '㎡', (FALSE), 'm^2', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2206, '㎢', (FALSE), 'km^2', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2207, '㎣', (FALSE), 'mm^3', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2208, '㎤', (FALSE), 'cm^3', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2209, '㎥', (FALSE), 'm^3', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2210, '㎦', (FALSE), 'km^3', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2211, '㎧', (FALSE), 'm/s', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2212, '㎨', (FALSE), 'm/s^2', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2213, '㎩', (FALSE), 'Pa', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2214, '㎪', (FALSE), 'kPa', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2215, '㎫', (FALSE), 'MPa', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2216, '㎬', (FALSE), 'GPa', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2217, '㎭', (FALSE), 'rad', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2218, '㎮', (FALSE), 'rad/s', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2219, '㎯', (FALSE), 'rad/s^2', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2220, '㎰', (FALSE), 'ps', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2221, '㎱', (FALSE), 'ns', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2222, '㎲', (FALSE), 'µs', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2223, '㎳', (FALSE), 'ms', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2224, '㎴', (FALSE), 'pV', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2225, '㎵', (FALSE), 'nV', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2226, '㎶', (FALSE), 'µV', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2227, '㎷', (FALSE), 'mV', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2228, '㎸', (FALSE), 'kV', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2229, '㎹', (FALSE), 'MV', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2230, '㎺', (FALSE), 'pW', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2231, '㎻', (FALSE), 'nW', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2232, '㎼', (FALSE), 'µW', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2233, '㎽', (FALSE), 'mW', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2234, '㎾', (FALSE), 'kW', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2235, '㎿', (FALSE), 'MW', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2236, '㏀', (FALSE), 'kΩ', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2237, '㏁', (FALSE), 'MΩ', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2238, '㏃', (FALSE), 'Bq', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2239, '㏄', (FALSE), 'cc', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2240, '㏅', (FALSE), 'cd', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2241, '㏆', (FALSE), 'C/kg', NULL, NULL, 'symbols', 'true', NULL);

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2242, '㏈()', (FALSE), 'dB', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2243, '㏉', (FALSE), 'Gy', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2244, '㏊', (FALSE), 'ha', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2245, '㏌', (FALSE), 'in', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2246, '㏏', (FALSE), 'kt', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2247, '㏐', (FALSE), 'lm', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2248, '㏓', (FALSE), 'lx', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2249, '㏔', (FALSE), 'mb', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2250, '㏕', (FALSE), 'mil', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2251, '㏖', (FALSE), 'mol', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2252, '㏗()', (FALSE), 'pH', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2253, '㏙', (FALSE), 'ppm', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2254, '㏛', (FALSE), 'sr', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2255, '㏜', (FALSE), 'Sv', NULL, NULL, 'symbols', 'true', 'true');

INSERT INTO units.unit ( id, name, base, value, amount, description, type, utf8, func ) VALUES (2256, '㏝', (FALSE), 'Wb', NULL, NULL, 'symbols', 'true', 'true');