Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171D33F41E1
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 00:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhHVWRa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Aug 2021 18:17:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229700AbhHVWR3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Aug 2021 18:17:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17MM3NYM083017;
        Sun, 22 Aug 2021 18:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=PgVp/OHYx+bmfu4y/jODW1/qakY1LoCzXW8iMXEXZ4k=;
 b=OudHtvBM2Y/CEYXxjMXyD6fp+fsbP4yAb8QsyMJ129VaK/egx26btdSxciafmb3UsOZD
 /XlVbKbv59mRNIH1T1xwN9F+L2X+8qKmfojgRNTfGjrpJuvd8QaxhsTBZ9kggX4VZWhh
 VX/pfzww2aOihdxw000d2XJV6FuFEbDt4ounyKtxQgQYTr2ShkZU2/YMht9MbakX+DqT
 Ll+SOqI2mJIzdOdS3yDaQCpfFbdaBQ6OlkMnmTgaUA0UEaTPintyuDpPUXfyijLglnpg
 iFCmR60nS4R4w/B5+/9LRVc6IIoAB5LMPP58QvROiRw4hqXGrPeWC/m8Zd67ykruB0OW UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3akf0u5q13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Aug 2021 18:16:46 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17MMCkSt111970;
        Sun, 22 Aug 2021 18:16:45 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3akf0u5q0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Aug 2021 18:16:45 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17MMBpt2024122;
        Sun, 22 Aug 2021 22:16:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3ajs48t7rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Aug 2021 22:16:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17MMD3MQ60096956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 22 Aug 2021 22:13:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C510AE045;
        Sun, 22 Aug 2021 22:16:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95D4AAE051;
        Sun, 22 Aug 2021 22:16:39 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.125.161])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 22 Aug 2021 22:16:39 +0000 (GMT)
Message-ID: <80ee29e0c202fa1af27e46dfe4be2cd04b6b61b2.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: reject unknown hash algorithms in ima_get_hash_algo
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>,
        "syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com" 
        <syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com>
Date:   Sun, 22 Aug 2021 18:16:38 -0400
In-Reply-To: <892b127f-d929-68da-7709-fa001935bfae@viveris.fr>
References: <20210822085522.3416-1-Simon.THOBY@viveris.fr>
         <892b127f-d929-68da-7709-fa001935bfae@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vR96jF5vqjBLBfFLmzmyXrKYS3QcbDqC
X-Proofpoint-ORIG-GUID: MuWRynceS1SBVCa69B6-MYaPZITud3_x
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-22_06:2021-08-20,2021-08-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108220146
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2021-08-22 at 09:00 +0000, THOBY Simon wrote:
> On 8/22/21 10:55 AM, THOBY Simon wrote:
> > The new function validate_hash_algo() assumed that ima_get_hash_algo()
> > always return a valid 'enum hash_algo', but it returned the
> > user-supplied value present in the digital signature without
> > any bounds checks.
> > 
> > Update ima_get_hash_algo() to always return a valid hash algorithm,
> > defaulting on 'ima_hash_algo' when the user-supplied value inside
> > the xattr is invalid.
> > 
> > Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
> > Reported-by: syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com
> > Fixes: 50f742dd9147 ("IMA: block writes of the security.ima xattr with
> > unsupported algorithms")
> > Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > ---
> >  security/integrity/ima/ima_appraise.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> > index 8f1eb7ef041e..dbba51583e7c 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -185,7 +185,8 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
> >  	switch (xattr_value->type) {
> >  	case EVM_IMA_XATTR_DIGSIG:
> >  		sig = (typeof(sig))xattr_value;
> > -		if (sig->version != 2 || xattr_len <= sizeof(*sig))
> > +		if (sig->version != 2 || xattr_len <= sizeof(*sig)
> > +		    || sig->hash_algo >= HASH_ALGO__LAST)
> >  			return ima_hash_algo;
> >  		return sig->hash_algo;
> >  		break;
> > 
> 
> Oops, I forgot to update the patch version, and to add a changelog.
> Here it is:
> - Updating the commit message
> - Adding the 'Fixes:' and 'Reviewed-by:' annotations
> 
> As the patch content didn't change, the comment on 
> syszbot ("This patch was successfully tested by syszbot, see
> https://syzkaller.appspot.com/bug?extid=e8bafe7b82c739eaf153.")
> is still true.
> 
> Sorry about that,

This looks fine.  Comments that you want to convey to
reviewers/maintainers, like the testing info, go after the patch
description after three-dash line.   Only the information that should
be retained should be in the patch description.

thanks,

Mimi

