Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89284314245
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 22:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbhBHVvm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Feb 2021 16:51:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236978AbhBHVvM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Feb 2021 16:51:12 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 118LWp3f183106;
        Mon, 8 Feb 2021 16:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ty9/RD73F+2obMKPNYY6TEK+gUiCqlJXpqHfEHG7Kvk=;
 b=OhAFPu2tI/5jFP80NP4Jfrf+m7bLy1Ha7NthNTsStnMcNFom5hOKCSQI+0gK+i11BLPW
 nJofii+XZQ+3yDrqz4HNS5zTRdxtWEofRKqEqoJ2iWGDpUMou8XLTqfEioqfkxpUCezy
 tEAcCAgBhcnBAxeITj1kB6vgofjWTRBLIbFvJ2FhEzn3/ea1tmojFWgM9OzqaG4ykZvk
 asRT+CRKufCV26gMNRykRtILxH01l4fwtvnhgarYTA2blFibg8oQK70hIdfwEekVfl+P
 VQOzWIlu6fu22GPb1IlNGSXblFi3mTvzRiecDP1htWMNAGZYEq8Qqo7+2YgNBtUVgtWX cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kcx0gvwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 16:50:21 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 118LmKBa048415;
        Mon, 8 Feb 2021 16:50:21 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36kcx0gvvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 16:50:20 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 118LjcUP017414;
        Mon, 8 Feb 2021 21:50:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 36hskb14g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Feb 2021 21:50:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 118LoFfw41877916
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Feb 2021 21:50:15 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E9EBA405C;
        Mon,  8 Feb 2021 21:50:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9619FA405F;
        Mon,  8 Feb 2021 21:50:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.48.239])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Feb 2021 21:50:13 +0000 (GMT)
Message-ID: <9bd1eaab236f095f1dbdc01752c3c6f487f33525.camel@linux.ibm.com>
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
Date:   Mon, 08 Feb 2021 16:50:12 -0500
In-Reply-To: <b6ee219924e7195070062b6453931595faa640af.camel@pengutronix.de>
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
         <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
         <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
         <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
         <d4eeefa0c13395e91850630e22d0d9e3690f43ac.camel@linux.ibm.com>
         <64472434a367060ddce6e03425156b8312a5ad6c.camel@pengutronix.de>
         <bd3246ebb4eae526c84efe2d27c6fadff662b0c8.camel@linux.ibm.com>
         <0be34899c9686b95cd22aa016f466523579cbeed.camel@pengutronix.de>
         <e9e7814c35d9ce5a6351a960081bf3c6b90bdca7.camel@linux.ibm.com>
         <b6ee219924e7195070062b6453931595faa640af.camel@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_13:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=972 bulkscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-02-08 at 15:38 +0100, Jan Lübbe wrote:

> As it seems that this feature would not be appropriate for all use-cases and
> threat models, I wonder if making it optional would be acceptable. Something
> like:
> 
> config TRUSTED_KEYS_IMPORT

To me "IMPORT" implies from a trusted source, which this is not. 
Perhaps "UNSAFE_IMPORT", "DEBUGGING_IMPORT, "DEVELOPMENT_IMPORT", ...

Defining a Kconfig with any of these names and the other changes below,
makes it very clear using predefined key data is not recommended.  My
concern with extending trusted keys to new trust sources is the
implication that the security/integrity is equivalent to the existing
discrete TPM.

>         bool "Allow creating TRUSTED KEYS from existing key material"
>         depends on TRUSTED_KEYS

Missing "default n"

>         help
>           This option adds support for creating new trusted keys from existing 
>           key material supplied by userspace, instead of using random numbers.
>           As with random trusted keys, userspace cannot extract the plain-text 

Once defined, as with random trusted keys, userspace cannot ...

>           key material again and will only ever see encrypted blobs.
>           
>           This option should *only* be enabled for use in a trusted
>           environment (such as during debugging/development or in a secured
>           factory). Also, consider using 'keyctl padd' instead of 'keyctl add' 

Even the "secured factory" is not a good idea.  Please limit the usage
to debugging/development.

>           to avoid exposing the plain-text key on the process command line.
> 
>           If you are unsure as to whether this is required, answer N.

The above would be fine.

thanks,

Mimi

