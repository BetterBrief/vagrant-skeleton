
echo "Installing PHP developer and pear... (for PECL and compiling)"
yum -y install php-devel php-pear

echo "Installing MongoDB PHP extension..."
pecl install mongo

MONGODB_PHP="/etc/php.d/mongo.ini"

echo "Add the MongoDB Extension to php.d"
if [ -f ${MONGODB_PHP} ]; then
     echo "$MONGODB_PHP found"
else
cat << 'EOF' > ${MONGODB_PHP}
; Enable the MongoDB extension module
extension=mongo.so
EOF
fi

echo "Restarting Apache..."
service httpd restart