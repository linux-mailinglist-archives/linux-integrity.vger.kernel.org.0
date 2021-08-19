Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790143F20A1
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 21:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhHSTcY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 15:32:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230504AbhHSTcX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 15:32:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JJGiEq125158;
        Thu, 19 Aug 2021 15:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IhMTpgaF+/XifSRpiET4PLlR+xw/gRZjXUzbqdSF69g=;
 b=hoAIyKJ1b4R8ErJcMVP5mfQgTpdeW8sgyA7/XjzwxcHfUbbNybHpGB6n0bzbPeuboL/I
 +bH5RDqL0KiLsK3LwFKchdcieQhr05Fw2OHH0iJRqO9W0aNQq0GeYWFZC30GHC0b5ygq
 ytpkSPq1lQI9LwHcnTrFkmtnvAc+FgapgofXxb1WJwTcTAKz1E9tfubDaepjVqrmTUQi
 pSe/tjmCRTH12sKK7mQpbJFD5BCdMwecd5sDARTa9/efp2TR5LW4VZUtEeeCUh3WBH7U
 /SkOqUz0qhr3bs939YvzXylGli/CuAw/oKeks00IyHCe86nEZVUU4onNHFpWJ0WGhWk/ RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3agp2d9hhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 15:31:33 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JJH4Fx126559;
        Thu, 19 Aug 2021 15:31:33 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3agp2d9hgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 15:31:33 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JJH1w3000800;
        Thu, 19 Aug 2021 19:31:31 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ae5f8gp06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 19:31:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JJRtnZ58786272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 19:27:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFF5C52052;
        Thu, 19 Aug 2021 19:31:28 +0000 (GMT)
Received: from sig-9-65-206-165.ibm.com (unknown [9.65.206.165])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BCBB752069;
        Thu, 19 Aug 2021 19:31:26 +0000 (GMT)
Message-ID: <78dfd42fb6de3b3c373be66e38d021f145740c86.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix infinite loop within "ima_match_policy"
 function.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        liqiong <liqiong@nfschina.com>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 19 Aug 2021 15:31:25 -0400
In-Reply-To: <ed27351e0574f58ee59a3024554b8b0c7293515f.camel@linux.ibm.com>
References: <20210819101529.28001-1-liqiong@nfschina.com>
         <8d17f252-4a93-f430-3f25-e75556ab01e8@viveris.fr>
         <ed27351e0574f58ee59a3024554b8b0c7293515f.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UIf0kseCI95q6VXNtSNaRFSTP6Cwb_pA
X-Proofpoint-GUID: cblgJ_wtl42znVymjdXO0ZckUKX-P02K
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_07:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-19 at 09:47 -0400, Mimi Zohar wrote:
> On Thu, 2021-08-19 at 12:58 +0000, THOBY Simon wrote:
> > Hi Liqiong,
> > 
> > On 8/19/21 12:15 PM, liqiong wrote:
> > > When "ima_match_policy" is looping while "ima_update_policy" changs
> > > the variable "ima_rules", then "ima_match_policy" may can't exit loop,
> > > and kernel keeps printf "rcu_sched detected stall on CPU ...".
> > > 
> > > It occurs at boot phase, systemd-services are being checked within
> > > "ima_match_policy,at the same time, the variable "ima_rules"
> > > is changed by a service.
> > 
> > First off, thanks for finding and identifying this nasty bug.
> 
> Once the initial builtin policy rules have been replaced by a custom
> policy, rules may only be appended by splicing the new rules with the
> existing rules.  There should never be a problem reading the rules at
> that point.   Does this problem occur before the builtin policy rules
> have been replaced with a custom policy?

Yes, the problem is limited to transitioning from the builtin policy to
the custom policy.   Adding a new lock around rcu code seems counter
productive, especially since switching the policy rules happens once,
normally during early boot before access to real root.  Please consider
Simon's suggestion or finding some other solution.

thanks,

Mimi

