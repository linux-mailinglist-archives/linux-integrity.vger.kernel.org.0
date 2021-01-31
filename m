Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8AD309CFB
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Jan 2021 15:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhAaOd0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 Jan 2021 09:33:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56856 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231388AbhAaOa0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 Jan 2021 09:30:26 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10VEMLt2065853;
        Sun, 31 Jan 2021 09:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=t6GOFFqXF4+RT2s3I0nJug5NJG5wMksRVJGgJbwHJ8Q=;
 b=JzzEb71TQyAUqIqVwBZI6Lm5Zqs5Vzy9nTTU3TSyzry9bPUCe3oiZ43M2hdPRHhF0FAJ
 kRiW5TOKl066NrG+fXKytf/hB3stXbaQs+/fly/5tPuloiU6uKF/ASGjmz2GnDOoxIF4
 E+6+nBTocAN9qPH6slDKic3htcMvT8GGGkVK0KNXsobtbx1xIwmziEFMBMrnuVjURTIY
 wRHIdcdXx+7aSTy0Z9xLhoXisG9D4gD27+FQc/hd3adpJJCSuzXk9MzeGrdpux7+w3pS
 W7X6RZOXt6QMBEXZtEB/Dj3Iz5mkTTB1FJoXrmHnh0wKF6Rygosh+QZIogYoRbNBG3dF fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36dx8m82gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 09:29:37 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10VETbT7085826;
        Sun, 31 Jan 2021 09:29:37 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36dx8m82gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 09:29:37 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10VES3CA003395;
        Sun, 31 Jan 2021 14:29:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 36cy38h1rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 14:29:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10VETOn533096086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 14:29:25 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09E2711C05B;
        Sun, 31 Jan 2021 14:29:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74D2611C04C;
        Sun, 31 Jan 2021 14:29:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.28.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 31 Jan 2021 14:29:30 +0000 (GMT)
Message-ID: <d4eeefa0c13395e91850630e22d0d9e3690f43ac.camel@linux.ibm.com>
Subject: Re: Migration to trusted keys: sealing user-provided key?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de
Date:   Sun, 31 Jan 2021 09:29:29 -0500
In-Reply-To: <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
         <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-31_04:2021-01-29,2021-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 mlxlogscore=951 impostorscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310076
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-01-31 at 15:14 +0100, Jan Lübbe wrote:
> On Sun, 2021-01-31 at 07:09 -0500, Mimi Zohar wrote:

<snip>

> > 
> > [1] The ima-evm-utils README contains EVM examples of "trusted" and
> > "user" based "encrypted" keys.
> 
> I assume you refer to
> https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/README#l143
> "Generate EVM encrypted keys" and "Generate EVM trusted keys (TPM based)"?
> 
> In both cases, the key used by EVM is a *newly generated* random key. The only
> difference is whether it's encrypted to a user key or a (random) trusted key.
 
The "encrypted" asymmetric key data doesn't change, "update" just
changes the key under which it is encrypted/decrypted.

Usage::

    keyctl add encrypted name "new [format] key-type:master-key-name
keylen"
        ring
    keyctl add encrypted name "load hex_blob" ring
    keyctl update keyid "update key-type:master-key-name"

Mimi

