Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8F0309DB1
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Jan 2021 16:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhAaM5r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 Jan 2021 07:57:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231314AbhAaMKv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 Jan 2021 07:10:51 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10VC2RQm065722;
        Sun, 31 Jan 2021 07:10:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=785VSoSRSR1skqkUMWCI5pfgN854rcbb+LK5rFkqE8A=;
 b=jb+1gPMMyVSdsX8rkalNesJF8eu+K6Vz3drFe14+1lzemGXU9CfQS6apIIsLdl4KV1Nf
 abkKH330XV+T6Zm46oEDJvAPaeITzjX+jYbl1m0jrPsAx2tzRN9mOe5EWDrc//6aPn+z
 jcboTRC0gMLf0GQ4ODquv7wqcrI14MNRO6qDEMiWB52t3j0y7/3Yvc1XGGab0PSMkPGH
 ciKWjS/11jOODc1AsGPJY5/zAcm1Kj2PMM5zs8T5wfbx7p96G7Kbq+Eumhf0geDeCcNp
 MvpKBMnz1W6ck/AR6HGhmmJCBOeycOlnU8+6pGLMvu/3Da1xZ6cyhlZtl/eboFqex1sE wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36dukv0p0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 07:10:03 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10VC9qGY094540;
        Sun, 31 Jan 2021 07:10:03 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36dukv0nyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 07:10:03 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10VC2UMv018774;
        Sun, 31 Jan 2021 12:10:01 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 36cy37rga6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 Jan 2021 12:10:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10VC9oMo25035082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Jan 2021 12:09:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD8F94C04A;
        Sun, 31 Jan 2021 12:09:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6C2A4C040;
        Sun, 31 Jan 2021 12:09:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.28.14])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 31 Jan 2021 12:09:56 +0000 (GMT)
Message-ID: <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
Subject: Re: Migration to trusted keys: sealing user-provided key?
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel@pengutronix.de,
        jlu@pengutronix.de
Date:   Sun, 31 Jan 2021 07:09:55 -0500
In-Reply-To: <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-01-31_04:2021-01-29,2021-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101310061
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-01-30 at 19:53 +0200, Jarkko Sakkinen wrote:
> On Thu, 2021-01-28 at 18:31 +0100, Ahmad Fatoum wrote:
> > Hello,
> > 
> > I've been looking into how a migration to using trusted/encrypted keys
> > would look like (particularly with dm-crypt).
> > 
> > Currently, it seems the the only way is to re-encrypt the partitions
> > because trusted/encrypted keys always generate their payloads from
> > RNG.
> > 
> > If instead there was a key command to initialize a new trusted/encrypted
> > key with a user provided value, users could use whatever mechanism they
> > used beforehand to get a plaintext key and use that to initialize a new
> > trusted/encrypted key. From there on, the key will be like any other
> > trusted/encrypted key and not be disclosed again to userspace.
> > 
> > What are your thoughts on this? Would an API like
> > 
> >   keyctl add trusted dmcrypt-key 'set <content>' # user-supplied content
> > 
> > be acceptable?
> 
> Maybe it's the lack of knowledge with dm-crypt, but why this would be
> useful? Just want to understand the bottleneck, that's all.

We upstreamed "trusted" & "encrypted" keys together in order to address
this sort of problem.   Instead of directly using a "trusted" key for
persistent file signatures being stored as xattrs, the "encrypted" key
provides one level of indirection.   The "encrypted" key may be
encrypted/decrypted with either a TPM based "trusted" key or with a
"user" type symmetric key[1].

Instead of modifying "trusted" keys, use a "user" type "encrypted" key.

Mimi

[1] The ima-evm-utils README contains EVM examples of "trusted" and
"user" based "encrypted" keys.

