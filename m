Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535D9266239
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Sep 2020 17:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgIKPfG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 11:35:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgIKPeu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 11:34:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08BEAsde079402;
        Fri, 11 Sep 2020 10:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=4jdpabALJcRG0Ff54RGULkHc+H8aLYR/WaE/focejS8=;
 b=T6krThn3DJ2NcA05aGPAy5TS3GbYDbLlVV9Q6G+YBwzDNr0H5uoRMZtuWYRf+hpmCZHZ
 EWfK3eBwMF3Qc8Os9XQo5cOuPPZ3w3Eu2yzNbDKEUfBJxCetBmwCmBrCE8WNG9qqoPa8
 iE3yMCMa7Alket0YEwB+6YnIKscSqNNkx5h1Zg/w+5gjelRknLv4ce0TLG5JAzMMl+mi
 BmJ+0aLDGaKiSr+/A0OFOIRJxSlqOe+/ST4+qFWEhsLazSk+nCfNSzoI/ojzQRAjxLFG
 +WTVqERAYMnxl3+Eu1f3f7cOrZkqN0Rj2TOrPfuNIWizvGSehH2z/RaFFO0uv3Pd459b 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gaerh2qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 10:21:29 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08BEDuYl092454;
        Fri, 11 Sep 2020 10:21:28 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gaerh2pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 10:21:28 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08BEGrBR003842;
        Fri, 11 Sep 2020 14:21:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 33c2a8faqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 14:21:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08BELNS025559396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 14:21:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CCEB4C059;
        Fri, 11 Sep 2020 14:21:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99F404C050;
        Fri, 11 Sep 2020 14:21:22 +0000 (GMT)
Received: from sig-9-65-251-51.ibm.com (unknown [9.65.251.51])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 11 Sep 2020 14:21:22 +0000 (GMT)
Message-ID: <7bc45e11c9af3fe65a08a379d7690866264a13e5.camel@linux.ibm.com>
Subject: Re: Potential IMA Signing Bug
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Alexander Gaidis <alexander_gaidis@brown.edu>,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com
Date:   Fri, 11 Sep 2020 10:21:21 -0400
In-Reply-To: <322722b2-4253-3069-4cbc-c15e5924f5fc@brown.edu>
References: <322722b2-4253-3069-4cbc-c15e5924f5fc@brown.edu>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_05:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1011 suspectscore=3
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110114
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2020-09-09 at 13:13 -0600, Alexander Gaidis wrote:
> I am wondering if the following behavior is a bug.
> 
> My system is Debian Buster with Linux kernel v5.7.13 running on x86_64
> Intel hardware. My kernel's configuration file has the following
> relevant security options (+ their dependencies) turned on:
> 
> ```
> CONFIG_INTEGRITY=y
> CONFIG_INTEGRITY_SIGNATURE=y
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
> CONFIG_INTEGRITY_AUDIT=y
> CONFIG_IMA=y
> CONFIG_IMA_MEASURE_PCR_IDX=10
> CONFIG_IMA_LSM_RULES=y
> CONFIG_IMA_NG_TEMPLATE=y
> CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> CONFIG_IMA_DEFAULT_HASH_SHA256=y
> CONFIG_IMA_DEFAULT_HASH="sha256"
> CONFIG_IMA_WRITE_POLICY=y
> CONFIG_IMA_READ_POLICY=y
> CONFIG_IMA_APPRAISE=y
> CONFIG_IMA_APPRAISE_BOOTPARAM=y
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> # CONFIG_INTEGRITY_TRUSTED_KEYRING is not set
> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> CONFIG_EVM=y
> CONFIG_EVM_ATTR_FSUUID=y
> ```
> 
> and I updated GRUB to include `ima_appraise=fix` to the boot parameters.
> The policy I load looks like the following:
> 
> ```
> measure fowner=1000
> appraise fowner=1000 appraise_type=imasig
> ```
> 
> To sign IMA hashes I load an x509 certificate onto root's `_ima` keyring
> via the following procedure (assume I have the file x509_ima.genkey as
> in the `evmctl` manpage):
> 
> ```
> root@deb:~# openssl req -new -nodes -utf8 -sha1 -days 36500 -batch \
> >    	        -x509 -config x509_ima.genkey \
> >	        -outform DER -out x509_ima.der -keyout privkey_ima.pem
> Generating a RSA private key
> ......+++++
> ....+++++
> writing new private key to 'privkey_ima.pem'
> -----
> root@deb:~# ima_id=`keyctl newring _ima @u`
> root@deb:~# cat x509_ima.der | keyctl padd asymmetric 'ima_cert' $ima_id
> 282969187
> root@deb:~# keyctl show
> Session Keyring
>  727602364 --alswrv      0     0  keyring: _ses
>   17430979 --alswrv      0 65534   \_ keyring: _uid.0
>  822262864 --alswrv      0     0       \_ keyring: _ima
>  282969187 --als--v      0     0           \_ asymmetric: ima_cert
> ```
> 
> I have a simple executable, `hello`, that prints a simple "Hello world!"
> message. Using the matching private key of the x509 certificate above
> and `evmctl` I can hash and sign the executable:
> 
> ```
> user@deb:~$ sudo evmctl -v ima_sign --key /root/privkey_ima.pem hello
> hash: 4409ab55775b430524cf9c9bbe798a8213de740e
> evm/ima signature: 136 bytes
> 03020277de1ee90080696c392a74513afcff14208fe5c3a56b466a360becf7ca5aa11a502fd249fc7fa04d7631d9cd10602ba460c0133773ce3c33562e5e0d9770b3c0714f7b19bba4e4de0b88b12d512b7fa99732118de59a3fc098e1655d531a60a3c6052c434959ab739d740a5125f435bf0550eb57c9d09195816c6749a0ab6390196893ef9164
> user@deb:~$ getfattr -m . -d hello
> # file: hello
> security.ima=0sAwICd94e6QCAaWw5KnRROvz/FCCP5cOla0ZqNgvs98paoRpQL9JJ/H+gTXYx2c0QYCukYMATN3POPDNWLl4Nl3CzwHFPexm7pOTeC4ixLVErf6mXMhGN5Zo/wJjhZV1TGmCjxgUsQ0lZq3OddApRJfQ1vwVQ61fJ0JGVgWxnSaCrY5AZaJPvkWQ=
> ```
> 
> After rebooting the machine in appraisal mode and loading the keys and
> policy I am unable to run the file as a user:
> 
> ```
> user@deb:~$ ./hello
> -bash: ./hello: Permission denied
> user@deb:~$ sudo dmesg | tail
> ...
> [   78.593140] integrity: no _ima keyring: -126
> [   78.593343] audit: type=1800 audit(1599673725.324:11): pid=582
> uid=1000 auid=1000 ses=1 subj==unconfined op=appraise_data
> cause=invalid-signature comm="bash" name="/home/user/hello" dev="sda1"
> ino=796088 res=0
> ```
> 
> However, after running the file as root and switching back to my user
> profile I am able to run the file just fine due to the caching of the
> integrity status of the file.

For some reason as a user you can't access the _ima keyring -
"integrity: no _ima keyring: -126".   Please create an additional
signed file and try accessing that one as user, after accessing the
original signed one succeeds.

> 
> It seems to me that if a user doesn't have access to the key that signs
> a file, they should not be able to access the file. Is this a correct
> assessment of IMA's behavior? If this is a deliberate design choice, can
> you please explain why?

A signed file is a signed file.   Who signed it shouldn't make a
difference.   The public key needs to be on the appropriate keyring and
accessible by the kernel.

Have you tried automatically loading the public key(s) via dracut or
systemd on boot?  Does that make a difference?

thanks,

Mimi

