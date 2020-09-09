Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C315A26367F
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Sep 2020 21:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgIITNn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Sep 2020 15:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITNl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Sep 2020 15:13:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A06C061573
        for <linux-integrity@vger.kernel.org>; Wed,  9 Sep 2020 12:13:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b16so1823100pjp.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Sep 2020 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brown.edu; s=google;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ts3fDm5aOGdcl4ZsmelPhRnAu5K5ipJMXAkyW3O7gc4=;
        b=ZANcL9+upnp/tDqMoqGGFrGRDatIF2nlW5a3e/NzYFe0eBTiN/TY4rl/0a0gNuUDHK
         qNo7UwP5tSLFrXGXbHJogcftGaPn/7yHjhlo380baVkRF0sGTZEQii4+IJJBTj+fLQLg
         nFXNjmdg4ObijYFg0snKwu2Av5DrLi1MRHuD45HFcYjpnp/H2uQLANHJ9jrJVmkY9Gek
         OhoZb/7PTRX6SN64cugxRaJY3vsie9AtmW15kRw8tHyGvRWS+OezpiXDZMdVJGk/NjJu
         zaOxqWuVMAYcB/XDpJio993/PLu/kk687wO5thjn5I7VeLDwYCN221R67hp3Lak9sKPI
         qU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ts3fDm5aOGdcl4ZsmelPhRnAu5K5ipJMXAkyW3O7gc4=;
        b=g/lLqZDRlWpono9cSsZ+eJmChVRp7U+j7Fph62K6P+LyEEj5ddBHZgydQlUfX8sHgW
         dWjKim2JFLlEMPaqW9ZsZsll99JzGoGn+br0HtjSSqtfUggMFINKrcD3JHRQfmLE2UVP
         5OGftkahpVuHngkLJ2r/qZ9S+jXHe9SJObCxmImYRE2U8bgNSudqB2G9n2rRNGcJ4Qy8
         2lcK/FqfqNNV+s8zgJ65EgO9QKHMXQRnkI8om7tVcsoXFltl8gFnvbRsKJO9mSnJ0kwM
         XGxBUqgCrc709v+hlumjfV81SPdMZoEgCn1x3N5lVpdwEueEa5IC2QUykvM1Cek19O3q
         xf0w==
X-Gm-Message-State: AOAM5323pn7OYC1KTey5puh2qy9xXlWeP4eFuwfrCqCy+9y+CLOjOltq
        BW2HMLM6fXYqecM6KOjbbAKN2yhJjSZQmTj1
X-Google-Smtp-Source: ABdhPJwSbHUToJvqfgWnzS/f1iQI0eeWsGHtUeBdZFjof/YTbaD5ZFWXiRTPS/C+CBeIa29mLV+hlA==
X-Received: by 2002:a17:90a:481:: with SMTP id g1mr1969870pjg.157.1599678820177;
        Wed, 09 Sep 2020 12:13:40 -0700 (PDT)
Received: from [192.168.0.151] (174-045-091-147.res.spectrum.com. [174.45.91.147])
        by smtp.gmail.com with ESMTPSA id y128sm3310067pfy.74.2020.09.09.12.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 12:13:39 -0700 (PDT)
From:   Alexander Gaidis <alexander_gaidis@brown.edu>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Subject: Potential IMA Signing Bug
Message-ID: <322722b2-4253-3069-4cbc-c15e5924f5fc@brown.edu>
Date:   Wed, 9 Sep 2020 13:13:38 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I am wondering if the following behavior is a bug.

My system is Debian Buster with Linux kernel v5.7.13 running on x86_64
Intel hardware. My kernel's configuration file has the following
relevant security options (+ their dependencies) turned on:

```
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
CONFIG_IMA_NG_TEMPLATE=y
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA256=y
CONFIG_IMA_DEFAULT_HASH="sha256"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_APPRAISE_BOOTPARAM=y
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
# CONFIG_INTEGRITY_TRUSTED_KEYRING is not set
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
```

and I updated GRUB to include `ima_appraise=fix` to the boot parameters.
The policy I load looks like the following:

```
measure fowner=1000
appraise fowner=1000 appraise_type=imasig
```

To sign IMA hashes I load an x509 certificate onto root's `_ima` keyring
via the following procedure (assume I have the file x509_ima.genkey as
in the `evmctl` manpage):

```
root@deb:~# openssl req -new -nodes -utf8 -sha1 -days 36500 -batch \
>    	        -x509 -config x509_ima.genkey \
>	        -outform DER -out x509_ima.der -keyout privkey_ima.pem
Generating a RSA private key
......+++++
....+++++
writing new private key to 'privkey_ima.pem'
-----
root@deb:~# ima_id=`keyctl newring _ima @u`
root@deb:~# cat x509_ima.der | keyctl padd asymmetric 'ima_cert' $ima_id
282969187
root@deb:~# keyctl show
Session Keyring
 727602364 --alswrv      0     0  keyring: _ses
  17430979 --alswrv      0 65534   \_ keyring: _uid.0
 822262864 --alswrv      0     0       \_ keyring: _ima
 282969187 --als--v      0     0           \_ asymmetric: ima_cert
```

I have a simple executable, `hello`, that prints a simple "Hello world!"
message. Using the matching private key of the x509 certificate above
and `evmctl` I can hash and sign the executable:

```
user@deb:~$ sudo evmctl -v ima_sign --key /root/privkey_ima.pem hello
hash: 4409ab55775b430524cf9c9bbe798a8213de740e
evm/ima signature: 136 bytes
03020277de1ee90080696c392a74513afcff14208fe5c3a56b466a360becf7ca5aa11a502fd249fc7fa04d7631d9cd10602ba460c0133773ce3c33562e5e0d9770b3c0714f7b19bba4e4de0b88b12d512b7fa99732118de59a3fc098e1655d531a60a3c6052c434959ab739d740a5125f435bf0550eb57c9d09195816c6749a0ab6390196893ef9164
user@deb:~$ getfattr -m . -d hello
# file: hello
security.ima=0sAwICd94e6QCAaWw5KnRROvz/FCCP5cOla0ZqNgvs98paoRpQL9JJ/H+gTXYx2c0QYCukYMATN3POPDNWLl4Nl3CzwHFPexm7pOTeC4ixLVErf6mXMhGN5Zo/wJjhZV1TGmCjxgUsQ0lZq3OddApRJfQ1vwVQ61fJ0JGVgWxnSaCrY5AZaJPvkWQ=
```

After rebooting the machine in appraisal mode and loading the keys and
policy I am unable to run the file as a user:

```
user@deb:~$ ./hello
-bash: ./hello: Permission denied
user@deb:~$ sudo dmesg | tail
...
[   78.593140] integrity: no _ima keyring: -126
[   78.593343] audit: type=1800 audit(1599673725.324:11): pid=582
uid=1000 auid=1000 ses=1 subj==unconfined op=appraise_data
cause=invalid-signature comm="bash" name="/home/user/hello" dev="sda1"
ino=796088 res=0
```

However, after running the file as root and switching back to my user
profile I am able to run the file just fine due to the caching of the
integrity status of the file.

It seems to me that if a user doesn't have access to the key that signs
a file, they should not be able to access the file. Is this a correct
assessment of IMA's behavior? If this is a deliberate design choice, can
you please explain why?

Thank you for your time!

Kind regards,
Alexander Gaidis
