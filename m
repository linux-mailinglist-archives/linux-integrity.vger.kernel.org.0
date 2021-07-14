Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA03E3C8884
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 18:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGNQT7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 12:19:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48115 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229897AbhGNQT6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 12:19:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EG4Wxw098252;
        Wed, 14 Jul 2021 12:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vgLx/IZLsmyIQmpkfUW+j00TP0Owi5TcQedtgRGQb2o=;
 b=GffcsbjYBoF2ZazyxPdQJB3TmTmmlpuL1NjedPRGWzQBwTayYPrY3+ddz2SfruvBeX5g
 seENwIkpsF3CQFmIeaB/QlsPbZVgOjzaZnx0kzNFiVREbvPgq0WisGlYJBlCcHu6v+fb
 Lzw51xKtjoyk17q9+E4oqAHXo011zpfcgVG51tzfue8VDueS7L0KvnCdn6Kr7gpVBJcN
 Ot+2iAZYjsBFLF/QjOPhynFJVLgYqImkXcF/ZzfocgVEbKrmgagjGIPb/+y8d1yq7HOd
 /2x73KpvFOpM7oUr9ar78HBrc7osspfQV5yQc/0C6GQ+t+E1UrOwPt29cgDaFCmBbzQd Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39sdy6jn5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 12:17:04 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16EG5fWd105908;
        Wed, 14 Jul 2021 12:17:04 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39sdy6jn4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 12:17:03 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16EGGkbl007537;
        Wed, 14 Jul 2021 16:17:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 39q368gyv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 16:17:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16EGGxTf23003646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jul 2021 16:16:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A541FAE057;
        Wed, 14 Jul 2021 16:16:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 768D8AE05A;
        Wed, 14 Jul 2021 16:16:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.127.85])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Jul 2021 16:16:58 +0000 (GMT)
Message-ID: <2d54bb0340e2971234084db68cc00e27089388a8.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v8 3/3] Read keyid from the cert appended
 to the key file
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 14 Jul 2021 12:16:57 -0400
In-Reply-To: <20210712054448.2471236-4-vt@altlinux.org>
References: <20210712054448.2471236-1-vt@altlinux.org>
         <20210712054448.2471236-4-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o9cA-Iha4Y2AHv7xr5C_Ukou5wlOAulk
X-Proofpoint-GUID: vVJbKG-e5PxVZHWsTEuGWRAZAgpM642Y
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_08:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Mon, 2021-07-12 at 08:44 +0300, Vitaly Chikunov wrote:
> 
> @@ -43,26 +43,43 @@ cat > test-ca.conf <<- EOF
>  	basicConstraints=CA:TRUE
>  	subjectKeyIdentifier=hash
>  	authorityKeyIdentifier=keyid:always,issuer
> +
> +	[ skid ]
> +	basicConstraints=CA:TRUE
> +	subjectKeyIdentifier=12345678
> +	authorityKeyIdentifier=keyid:always,issuer
>  EOF
>  fi

On my system:
$ openssl version
OpenSSL 1.1.1g FIPS  21 Apr 2020

Not sure this has anything to do with the reason that "skid" is not
supported.   The resulting files are empty.

ls -lat *skid*
-rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.key
-rw-rw-r--. 1 mimi mimi 0 Jul 14 12:02 test-rsa1024_skid.pub

- openssl pkey -in test-rsa1024.key -out test-rsa1024.pub -pubout
- openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509
-extensions skid -config test-ca.conf -newkey rsa:1024 -out test-
rsa1024_skid.cer -outform DER -keyout test-rsa1024_skid.key
Using configuration from test-ca.conf
Error Loading extension section skid   <===


Then the rest of the tests fail.  Probably should check not only if the
file exists, but the size of the file as well.

- openssl pkey -in test-rsa1024_skid.key -out test-rsa1024_skid.pub
-pubout
Can't open test-rsa1024_skid.key for reading, No such file or directory
140493815547712:error:02001002:system library:fopen:No such file or
directory:crypto/bio/bss_file.c:69:fopen('test-rsa1024_skid.key','r')
140493815547712:error:2006D080:BIO routines:BIO_new_file:no such
file:crypto/bio/bss_file.c:76:
unable to load key


- openssl x509 -inform DER -in test-rsa1024_skid.cer
Can't open test-rsa1024_skid.cer for reading, No such file or directory
139636313208640:error:02001002:system library:fopen:No such file or
directory:crypto/bio/bss_file.c:69:fopen('test-rsa1024_skid.cer','rb')
139636313208640:error:2006D080:BIO routines:BIO_new_file:no such
file:crypto/bio/bss_file.c:76:
unable to load certificate

Mimi

