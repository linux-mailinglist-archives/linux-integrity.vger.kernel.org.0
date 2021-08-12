Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198263EAA45
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbhHLScU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 14:32:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9116 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233517AbhHLScS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 14:32:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CI3vk2086213;
        Thu, 12 Aug 2021 14:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8sKktw1/45R7QcPWdqSHJBJ4CkoUYmXGhXH+vUDVkpY=;
 b=j4s3UqzW4JSxy+TYmjPAiF9vEol0Xp16s1glW6rPDkwpxgR5DlNEPexSWedZF/i+86iO
 xL1OymTFL04oB3D0G8nmLJpCf5VvODoHlu86UlOUl84xQbYFQTa+6SqxiUpEsaJQt7Zb
 RGlVB3L6HYPqF9f6MCTiXqIOkgd1FfnhEJ34QBruhfy3tDL7Cjepw1NBLelBD5kuj4tj
 r61IM7mLoud1GAgs3qs9ip8H2ShCHFbWk8uN9dau8hHKeUu3bBwOuPPEx6MF9Kk/kTl3
 EzI0TeaZoy+m/3tNvhhUTRyGPTxPyKB2DXmARidVPPAlBNWPHhWewRqqxYVh4CY7auZs KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ad5sde239-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 14:31:50 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17CI4OGc092416;
        Thu, 12 Aug 2021 14:31:50 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ad5sde22u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 14:31:50 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CIUY9p002408;
        Thu, 12 Aug 2021 18:31:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3abujqut65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 18:31:48 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CIVkHC58261782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 18:31:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F31EF4C059;
        Thu, 12 Aug 2021 18:31:45 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A10CC4C04A;
        Thu, 12 Aug 2021 18:31:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.76.214])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 18:31:44 +0000 (GMT)
Message-ID: <aef8a1e8cee322409ef3dc6723c7e77bc16f6b2f.camel@linux.ibm.com>
Subject: Re: [PATCH v7 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Thu, 12 Aug 2021 14:31:43 -0400
In-Reply-To: <c705ef557f40289d58ab7cbab8c2c0e7b888671e.camel@linux.ibm.com>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
         <20210811114037.201887-5-simon.thoby@viveris.fr>
         <84b3a572eb5fc1ec81291656c9f9af00568bff9f.camel@linux.ibm.com>
         <023a0ec1-aed7-9862-e0c9-a825d46ade0f@viveris.fr>
         <c705ef557f40289d58ab7cbab8c2c0e7b888671e.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ud8vKO5Om3JBGA7-N65SfnmiwiMaRiYk
X-Proofpoint-GUID: 6pjfSrxpYe_iRLGZkvnJvU8UyYxDXGEo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108120117
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Thu, 2021-08-12 at 09:16 -0400, Mimi Zohar wrote:
> On Thu, 2021-08-12 at 08:06 +0000, THOBY Simon wrote:

> > However your comment does applies to the next patch ("IMA: introduce a new policy
> > option func=SETXATTR_CHECK"), and we probably could restrict the algorithms referenced in
> > ima_setxattr_allowed_hash_algorithms to ones the current kernel can use. 
> > The easiest way to enforce this would probably be to check that when parsing 'appraise_algos'
> > in ima_parse_appraise_algos(), we only add algorithms that are available, ignoring - or
> > rejecting, according to the outcome of the discussion above - the other algorithms. That way,
> > we do not have to pay the price of allocating a hash object every time validate_hash_algo() is
> > called.
> > 
> > Would it be ok if I did that?
> 
> Without knowing and understanding all the environments in which IMA is
> enabled (e.g. front end, back end build system), you're correct -
> protecting the user from themselves -might not be the right answer.
> 
> What you suggested, above, would be the correct solution.  Perhaps post
> that change as a separate patch, on top of this patch set, for
> additional discussion.

Before posting the patch, please fix your user name and email address
in the git configuration.  scripts/checkpatch.pl is complaining:

ERROR: Missing Signed-off-by: line by nominal patch author 'THOBY Simon
<Simon.THOBY@viveris.fr>'

total: 1 errors, 0 warnings, 218 lines checked

thanks,

Mimi

