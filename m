Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A13E71040D3
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Nov 2019 17:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfKTQaT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Nov 2019 11:30:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42456 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfKTQaT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Nov 2019 11:30:19 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 293D620B7185;
        Wed, 20 Nov 2019 08:30:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 293D620B7185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574267417;
        bh=Id+4bYRC49+0/WFMWhRorOtnr8nfzkLAWke26BR9CHA=;
        h=Subject:From:To:References:Cc:Date:In-Reply-To:From;
        b=QhnDx3KlUw+EzCQB7OklMfq7+sOIASu0iS8mn+euA0F7Tb/IBvqjHT5uacYZvmiMw
         H7LI+Pq6Nx8Dy0lc6HLai2kOb7kMJrPH4XfqvjmjSIGTIIuw1lFR6s7xDycgVIxgQF
         xEHz/5uRh3pBvuHljAni1HKUCinYgm+FJ3yPaaiQ=
Subject: Validating key measurement
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
References: <20191118223818.3353-1-nramas@linux.microsoft.com>
 <20191118223818.3353-5-nramas@linux.microsoft.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, bauerman@linux.ibm.com
Message-ID: <faab8e25-6aac-e44d-2364-ab2d0eca36a6@linux.microsoft.com>
Date:   Wed, 20 Nov 2019 08:30:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118223818.3353-5-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/18/19 2:38 PM, Lakshmi Ramasubramanian wrote:

Hi Mimi,

I have described below how we can validate key measurement using the 
data in the IMA log, tools such as openssl, etc.

Also, I have included how the key measurement data can be used to 
correlate with ima-sig and ima-modsig entries (have taken some of this 
from Nayna's patch on "appraising using blacklist of file hash".

Appreciate if you could please review and let me know if I should add 
more info.

thanks,
  -lakshmi

> 
> The following example illustrates how key measurement can be verified.
> 
> Sample IMA Policy entry to measure keys
> (Added in the file /etc/ima/ima-policy):
> measure func=KEY_CHECK keyrings=.ima|.evm|.blacklist template=ima-buf
> 
> Build the kernel with this patch set applied and reboot to that kernel.
> 
> Ensure the IMA policy is applied:
> 
> root@nramas:/home/nramas# cat /sys/kernel/security/ima/policy
> measure func=KEY_CHECK keyrings=.ima|.evm|.blacklist template=ima-buf
> 
> View the initial IMA measurement log:
> 
> root@nramas:/home/nramas# cat /sys/kernel/security/ima/ascii_runtime_measurements
> 10 67ec... ima-ng sha1:b5466c508583f0e633df83aa58fc7c5b67ccf667 boot_aggregate
> 
> Now, add a certificate in DER format (for example, x509_ima.der) to
> the .ima keyring:
> 
> root@nramas:/home/nramas# keyctl show %:.ima
> Keyring
>   547515640 ---lswrv      0     0  keyring: .ima
> 
> root@nramas:/home/nramas# evmctl import x509_ima.der 547515640
> 
> root@nramas:/home/nramas# keyctl show %:.ima
> Keyring
>   547515640 ---lswrv      0     0  keyring: .ima
>   809678766 --als--v      0     0   \_ asymmetric: hostname: whoami signing key: 052dd247dc3c36...
> 
> View the updated IMA measurement log:
> 
> root@nramas:/home/nramas# cat /sys/kernel/security/ima/ascii_runtime_measurements
> 10 67ec... ima-ng sha1:b5466c508583f0e633df83aa58fc7c5b67ccf667 boot_aggregate
> 10 3adf... ima-buf sha256:27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b .ima 30818902818100ee96b264072a42888f78a2f9b8198467a3ad97d126f3d1cc1c24d23e7185cc743b04d4a54254ca16e1e11ed4450deb98b1f7bb4288424570fabcfc6d5aa93a2a14fa2b7835ac877cfea761e5ff414c6ee274eff26f8bd6c484312e56619299acf0dbd224b87c3883b66a9393d21af8962458663b0ac1706c63773cd50e8236270203010001
> root@nramas:/home/nramas#
> 
> The public key of x509_ima.der certificate and the key's SHA-256 hash
> are included in the IMA log.
> 
> For example, in the above IMA log entry the public key is the following:
> 
> 30818902818100ee96b264072a42888f78a2f9b8198467a3ad97d126f3d1cc1c24d23e7185cc743b04d4a54254ca16e1e11ed4450deb98b1f7bb4288424570fabcfc6d5aa93a2a14fa2b7835ac877cfea761e5ff414c6ee274eff26f8bd6c484312e56619299acf0dbd224b87c3883b66a9393d21af8962458663b0ac1706c63773cd50e8236270203010001
> 
> sha256:27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b
> 
> root@nramas:/home/nramas# cat /sys/kernel/security/ima/ascii_runtime_measurements |
>                            grep " .ima" | cut -d' ' -f 6 | xxd -r -p | sha256sum
> 27c915b8ddb9fae7214cf0a8a7043cc3eeeaa7539bcb136f8427067b5f6c3b7b
> root@nramas:/home/nramas#
> 
> SHA-256 hash in the IMA log and the above output should match.
> 
> Now run the following "openssl" command to display
> various fields of x509_ima.der certificate:
> 
> Verify the "Modulus" and the "Exponent" with that
> in the public key data in the IMA log entry.
> Note that the "Modulus" in the IMA log entry follows
> the RSA Header (For example, 308189028181)
> The "Exponent" is the last 3 hex numbers in the IMA log
> (For example, 0x01 0x00 0x01)
> 
> root@nramas:/home/nramas# openssl x509 -in x509_ima.der -inform der -noout -text
> Certificate:
>      Data:
>          Version: 3 (0x2)
>          Serial Number:
>              5b:e0:23:4f:f3:ad:f0:50:34:9b:33:b8:94:65:a6:aa:b6:e3:39:f7
>          Signature Algorithm: sha256WithRSAEncryption
>          Issuer: O = hostname, CN = whoami signing key, emailAddress = whoami@hostname
>          Validity
>              Not Before: Aug 22 02:29:02 2019 GMT
>              Not After : Aug 21 02:29:02 2020 GMT
>          Subject: O = hostname, CN = whoami signing key, emailAddress = whoami@hostname
>          Subject Public Key Info:
>              Public Key Algorithm: rsaEncryption
>                  RSA Public-Key: (1024 bit)
>                  Modulus:
>                      00:ee:96:b2:64:07:2a:42:88:8f:78:a2:f9:b8:19:
>                      84:67:a3:ad:97:d1:26:f3:d1:cc:1c:24:d2:3e:71:
>                      85:cc:74:3b:04:d4:a5:42:54:ca:16:e1:e1:1e:d4:
>                      45:0d:eb:98:b1:f7:bb:42:88:42:45:70:fa:bc:fc:
>                      6d:5a:a9:3a:2a:14:fa:2b:78:35:ac:87:7c:fe:a7:
>                      61:e5:ff:41:4c:6e:e2:74:ef:f2:6f:8b:d6:c4:84:
>                      31:2e:56:61:92:99:ac:f0:db:d2:24:b8:7c:38:83:
>                      b6:6a:93:93:d2:1a:f8:96:24:58:66:3b:0a:c1:70:
>                      6c:63:77:3c:d5:0e:82:36:27
>                  Exponent: 65537 (0x10001)
>          X509v3 extensions:
>              X509v3 Basic Constraints: critical
>                  CA:FALSE
>              X509v3 Key Usage:
>                  Digital Signature
>              X509v3 Subject Key Identifier:
>                  05:2D:D2:47:DC:3C:36:D6:D6:06:75:FE:7A:E8:69:79:0B:E5:61:71
>              X509v3 Authority Key Identifier:
>                  keyid:E3:67:10:F0:83:4C:97:3E:D9:4A:18:6F:BC:D2:23:75:B4:5E:24:54
> 
>      Signature Algorithm: sha256WithRSAEncryption
>           b1:2f:ae:ff:1e:0e:39:0c:fd:5e:b7:14:0a:f3:b7:a6:53:cb:
>           49:c6:ab:0a:23:be:24:c0:35:33:1d:76:00:c8:f7:58:f9:df:
>           7f:df:c5:ee:b6:fe:c3:58:59:20:3e:ca:0e:4f:01:f9:a7:9a:
>           58:be:63:09:47:cb:95:9a:52:d3:f2:de:96:f2:10:d4:92:47:
>           c3:3a:62:26:dc:2a:52:ee:54:10:69:ed:3c:62:1f:87:67:fd:
>           36:a0:61:e9:a6:1a:db:5d:1d:d3:44:99:d9:9a:1c:e6:ba:a4:
>           96:b4:f5:e2:26:8b:fc:52:c3:ee:a4:a6:b7:b5:18:1f:08:52:
>           4a:ee
> root@nramas:/home/nramas#
> 
> An ima-sig entry for a kernel module, say, kheaders.ko
> from the IMA log entry is given below:
> 
> 10 0c98... ima-sig
> sha256:3bc6ed4f0b4d6e31bc1dbc9ef844605abc7afdc6d81a57d77a1ec9407997c40
> 2 /usr/lib/modules/5.4.0-rc3+/kernel/kernel/kheaders.ko
> 03020BE561710100abcde...
> 
> In the above 0BE56171 is the Key ID of the key used to verify
> the IMA signature. This Key ID is the last 4 hex digits of
> the subject key identifier displayed in openssl output
> for the certificate x509_ima.der (Which is the IMA certificate
> used to sign the kernel module).
> 
> X509v3 Subject Key Identifier:
>     05:2D:D2:47:DC:3C:36:D6:D6:06:75:FE:7A:E8:69:79:0B:E5:61:71
> 
> The ima-modsig entry for the same kernel module is:
> 
> 10 82aa... ima-modsig
> sha256:3bc6ed4f0b4d6e31bc1dbc9ef844605abc7afdc6d81a57d77a1ec9407997c40
> 2 /usr/lib/modules/5.4.0rc3+/kernel/kernel/kheaders.ko
> sha256:77fa889b35a05338ec52e51591c1b89d4c8d1c99a21251d7c22b1a8642a6bad3
> 30818902818100ee96b264072a42888f78a2f9b8198467a3ad97d126f3d1cc1c24d23e7185cc743b04d4a54254ca16e1e11ed4450deb98b1f7bb4288424570fabcfc6d5aa93a2a14fa2b7835ac877cfea761e5ff414c6ee274eff26f8bd6c484312e56619299acf0dbd224b87c3883b66a9393d21af8962458663b0ac1706c63773cd50e8236270203010001
> 
> If the kernel module was signed by x509_ima.der certificate then
> the public key entry in the ima-modsig should match the public key
> for the key measurement for x509_ima.der.
> 
> The above can be used to correlate the key measurement IMA entry,
> ima-sig and ima-modsig entries using the same key.
