Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3773F267CA2
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Sep 2020 00:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgILWTs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Sep 2020 18:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgILWTr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Sep 2020 18:19:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82914C061573
        for <linux-integrity@vger.kernel.org>; Sat, 12 Sep 2020 15:19:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so2636316plk.3
        for <linux-integrity@vger.kernel.org>; Sat, 12 Sep 2020 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brown.edu; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SL1QWPsdoFfacq/RUouTUMH5XKQFCE7evyt9sEaotD4=;
        b=Xp4ift452LDzuKrkmKX/FtGgiPUbrOLLgqG7MhNq5ISR/bPbhW0IXkwDno6z/IYQV7
         uXVNGq0wNP7WDkBud+3qEGqT4S/EKjbgmptXYEETD5WcqJInW82va6S8o3OX1JvHZgpp
         RUJOlr/SqKLEtKP4v+XeTgnrZhih0Va9ilHgm7DvBqu7ccvsDEftTHpl8Cfo2vstdbmy
         W7R4+fUmjFHAfy8Z8BwLf8poDGMSOKIBOQ3eiXObemiwa1WzvhFOPYzxcofVhSaLM6xq
         2O+PZV0F5fTj5FhywFNKjHn6W5ZDUDB4biCjTbTjwlFZUi472n0aSjWYW9fernrBJQUI
         KLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SL1QWPsdoFfacq/RUouTUMH5XKQFCE7evyt9sEaotD4=;
        b=jg5rbkJNkXnTXaBtLsTiM1ILPPrhQypTjUXSgrsmSr1xEGWThrEAGkwGj+TWr2pDnl
         0wF4HTmECz4bTM8Z/4qjsLMjVs3rxPD2+uX33pajoZ6b0SNWlo1/TqbYD5QZhWRejCL8
         6tH+Q4gciTUQukiKrZlO+fjrlanVTR+p5kuA5CmjizRIKfJC748IC+kTGHQvq0RF4DXL
         xa0hfkbEVnV+P45N6F5q5KCIUuUKLQ1K9ZAvFZ83G0/wqdUeJ0Yd8HP2fgX1j0Q/T7vo
         n7Sm7Q1MzKsoDaTJCevbyPam9X/9C9mLHPIP+WT35djjSJ2c6SOWKsviNu34jCeSTN+K
         v7ew==
X-Gm-Message-State: AOAM530tnh6gh3Yz2UPPx0KuhnKMqGxfhe6l0eWCJzuWVgsevtY9t5JV
        xkWoNHy1tPqVN/BPMCNByg6dNA==
X-Google-Smtp-Source: ABdhPJyCAFZx0jaOVNf1nxIjj/azJtaUSc7wNMYSLUtjX1IEjUcHNG2vxiIIYvbSN7rxj2kzSzYXHQ==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr7682818pld.1.1599949183497;
        Sat, 12 Sep 2020 15:19:43 -0700 (PDT)
Received: from [192.168.0.151] (174-045-091-147.res.spectrum.com. [174.45.91.147])
        by smtp.gmail.com with ESMTPSA id t20sm5602542pgj.27.2020.09.12.15.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2020 15:19:42 -0700 (PDT)
Subject: Re: Potential IMA Signing Bug
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com
References: <322722b2-4253-3069-4cbc-c15e5924f5fc@brown.edu>
 <7bc45e11c9af3fe65a08a379d7690866264a13e5.camel@linux.ibm.com>
From:   Alexander Gaidis <alexander_gaidis@brown.edu>
Message-ID: <726a6968-9829-18a5-4d3b-563b5dd02145@brown.edu>
Date:   Sat, 12 Sep 2020 16:19:41 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7bc45e11c9af3fe65a08a379d7690866264a13e5.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/11/20 8:21 AM, Mimi Zohar wrote:
> On Wed, 2020-09-09 at 13:13 -0600, Alexander Gaidis wrote:
>> I am wondering if the following behavior is a bug.
>>
>> My system is Debian Buster with Linux kernel v5.7.13 running on x86_64
>> Intel hardware. My kernel's configuration file has the following
>> relevant security options (+ their dependencies) turned on:
>>
>> ```
>> CONFIG_INTEGRITY=y
>> CONFIG_INTEGRITY_SIGNATURE=y
>> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
>> CONFIG_INTEGRITY_AUDIT=y
>> CONFIG_IMA=y
>> CONFIG_IMA_MEASURE_PCR_IDX=10
>> CONFIG_IMA_LSM_RULES=y
>> CONFIG_IMA_NG_TEMPLATE=y
>> CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
>> CONFIG_IMA_DEFAULT_HASH_SHA256=y
>> CONFIG_IMA_DEFAULT_HASH="sha256"
>> CONFIG_IMA_WRITE_POLICY=y
>> CONFIG_IMA_READ_POLICY=y
>> CONFIG_IMA_APPRAISE=y
>> CONFIG_IMA_APPRAISE_BOOTPARAM=y
>> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
>> # CONFIG_INTEGRITY_TRUSTED_KEYRING is not set
>> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
>> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
>> CONFIG_EVM=y
>> CONFIG_EVM_ATTR_FSUUID=y
>> ```
>>
>> and I updated GRUB to include `ima_appraise=fix` to the boot parameters.
>> The policy I load looks like the following:
>>
>> ```
>> measure fowner=1000
>> appraise fowner=1000 appraise_type=imasig
>> ```
>>
>> To sign IMA hashes I load an x509 certificate onto root's `_ima` keyring
>> via the following procedure (assume I have the file x509_ima.genkey as
>> in the `evmctl` manpage):
>>
>> ```
>> root@deb:~# openssl req -new -nodes -utf8 -sha1 -days 36500 -batch \
>>>    	        -x509 -config x509_ima.genkey \
>>> 	        -outform DER -out x509_ima.der -keyout privkey_ima.pem
>> Generating a RSA private key
>> ......+++++
>> ....+++++
>> writing new private key to 'privkey_ima.pem'
>> -----
>> root@deb:~# ima_id=`keyctl newring _ima @u`
>> root@deb:~# cat x509_ima.der | keyctl padd asymmetric 'ima_cert' $ima_id
>> 282969187
>> root@deb:~# keyctl show
>> Session Keyring
>>  727602364 --alswrv      0     0  keyring: _ses
>>   17430979 --alswrv      0 65534   \_ keyring: _uid.0
>>  822262864 --alswrv      0     0       \_ keyring: _ima
>>  282969187 --als--v      0     0           \_ asymmetric: ima_cert
>> ```
>>
>> I have a simple executable, `hello`, that prints a simple "Hello world!"
>> message. Using the matching private key of the x509 certificate above
>> and `evmctl` I can hash and sign the executable:
>>
>> ```
>> user@deb:~$ sudo evmctl -v ima_sign --key /root/privkey_ima.pem hello
>> hash: 4409ab55775b430524cf9c9bbe798a8213de740e
>> evm/ima signature: 136 bytes
>> 03020277de1ee90080696c392a74513afcff14208fe5c3a56b466a360becf7ca5aa11a502fd249fc7fa04d7631d9cd10602ba460c0133773ce3c33562e5e0d9770b3c0714f7b19bba4e4de0b88b12d512b7fa99732118de59a3fc098e1655d531a60a3c6052c434959ab739d740a5125f435bf0550eb57c9d09195816c6749a0ab6390196893ef9164
>> user@deb:~$ getfattr -m . -d hello
>> # file: hello
>> security.ima=0sAwICd94e6QCAaWw5KnRROvz/FCCP5cOla0ZqNgvs98paoRpQL9JJ/H+gTXYx2c0QYCukYMATN3POPDNWLl4Nl3CzwHFPexm7pOTeC4ixLVErf6mXMhGN5Zo/wJjhZV1TGmCjxgUsQ0lZq3OddApRJfQ1vwVQ61fJ0JGVgWxnSaCrY5AZaJPvkWQ=
>> ```
>>
>> After rebooting the machine in appraisal mode and loading the keys and
>> policy I am unable to run the file as a user:
>>
>> ```
>> user@deb:~$ ./hello
>> -bash: ./hello: Permission denied
>> user@deb:~$ sudo dmesg | tail
>> ...
>> [   78.593140] integrity: no _ima keyring: -126
>> [   78.593343] audit: type=1800 audit(1599673725.324:11): pid=582
>> uid=1000 auid=1000 ses=1 subj==unconfined op=appraise_data
>> cause=invalid-signature comm="bash" name="/home/user/hello" dev="sda1"
>> ino=796088 res=0
>> ```
>>
>> However, after running the file as root and switching back to my user
>> profile I am able to run the file just fine due to the caching of the
>> integrity status of the file.
> 
> For some reason as a user you can't access the _ima keyring -
> "integrity: no _ima keyring: -126".   Please create an additional
> signed file and try accessing that one as user, after accessing the
> original signed one succeeds.
> 

I could access the second file after running the first one as root. See
below:

```
user@deb:~$ getfattr -m . -d hello*
# file: hello
security.ima=0sAwICd94e6QCAaWw5KnRROvz/FCCP5cOla0ZqNgvs98paoRpQL9JJ/H+gTXYx2c0QYCukYMATN3POPDNWLl4Nl3CzwHFPexm7pOTeC4ixLVErf6mXMhGN5Zo/wJjhZV1TGmCjxgUsQ0lZq3OddApRJfQ1vwVQ61fJ0JGVgWxnSaCrY5AZaJPvkWQ=

# file: hello2
security.ima=0sAwICd94e6QCAaWw5KnRROvz/FCCP5cOla0ZqNgvs98paoRpQL9JJ/H+gTXYx2c0QYCukYMATN3POPDNWLl4Nl3CzwHFPexm7pOTeC4ixLVErf6mXMhGN5Zo/wJjhZV1TGmCjxgUsQ0lZq3OddApRJfQ1vwVQ61fJ0JGVgWxnSaCrY5AZaJPvkWQ=

user@deb:~$ ./hello
-bash: ./hello: Permission denied
user@deb:~$ ./hello2
-bash: ./hello2: Permission denied
user@deb:~$ sudo dmesg | tail
...
[  110.374508] integrity: no _ima keyring: -126
[  110.374620] integrity: no _ima keyring: -126
[  110.375295] audit: type=1800 audit(1599931642.814:10): pid=594
uid=1000 auid=1000 ses=1 subj==unconfined op=appraise_data
cause=invalid-signature comm="bash" name="/home/user/hello" dev="sda1"
ino=796088 res=0
[  110.375300] audit: type=1800 audit(1599931642.814:11): pid=594
uid=1000 auid=1000 ses=1 subj==unconfined op=appraise_data
cause=invalid-signature comm="bash" name="/home/user/hello" dev="sda1"
ino=796088 res=0
[  112.556255] integrity: no _ima keyring: -126
[  112.556382] integrity: no _ima keyring: -126
[  112.556401] audit: type=1800 audit(1599931644.994:12): pid=595
uid=1000 auid=1000 ses=1 subj==unconfined op=appraise_data
cause=invalid-signature comm="bash" name="/home/user/hello2" dev="sda1"
ino=796089 res=0
[  112.556449] audit: type=1800 audit(1599931644.994:13): pid=595
uid=1000 auid=1000 ses=1 subj==unconfined op=appraise_data
cause=invalid-signature comm="bash" name="/home/user/hello2" dev="sda1"
ino=796089 res=0
user@deb:~$ su -
Password:
root@deb:~# /home/user/hello
Hello everyone!
root@deb:~# logout
user@deb:~$ ./hello
Hello everyone!
user@deb:~$ ./hello2
Hello everyone!
```

>>
>> It seems to me that if a user doesn't have access to the key that signs
>> a file, they should not be able to access the file. Is this a correct
>> assessment of IMA's behavior? If this is a deliberate design choice, can
>> you please explain why?
> 
> A signed file is a signed file.   Who signed it shouldn't make a
> difference.   The public key needs to be on the appropriate keyring and
> accessible by the kernel.
> 
> Have you tried automatically loading the public key(s) via dracut or
> systemd on boot?  Does that make a difference?

Yes I have, and it does not make a difference.

> 
> thanks,
> 
> Mimi

Thank you for your time!

Warm regards,
Alexander
