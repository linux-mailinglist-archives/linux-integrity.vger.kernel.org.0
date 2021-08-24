Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BE53F5E1B
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Aug 2021 14:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhHXMjs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Aug 2021 08:39:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237196AbhHXMjr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Aug 2021 08:39:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17OCY3vn118550;
        Tue, 24 Aug 2021 08:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1+jTVe2SbG0OIxYvjCqJfmIEo15dcWnkJJD8WSTNT2c=;
 b=Gwb4OXfPkoasReWabIHnDbDFpRVl+A3SWPFqbj5OM4FjYGtiytDgaI+HJ8E6neL1sDyr
 jI/TsUV1HHYcS4LGDqfMAqdSDTGwlJHJ2aYjVQiaNGVQo6bSgQXtvFj1pP3O0Eu8C6uY
 cftRVwkWoBM8BZMpXNqJ0x4ppJ0bTmnePqsjw6rcEihB7HzyFUgtb5DgqPpb081pxtRv
 LJ7u7HEeuD15lMTRfkdU7pzxFvpaV1IDnrKuHtAZWiX77YR8x6DOfK2YxgmcsyX/rS00
 roSuMW35a8ijfE9QrsRlIEYbuvhCbfoLc5Pg8MlS2ERmeT9D3aw6VYTv/kKkCs3zyl1t uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3amvttpu9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 08:38:50 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17OCYNwK120631;
        Tue, 24 Aug 2021 08:38:50 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3amvttpu81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 08:38:50 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17OCbRwj027031;
        Tue, 24 Aug 2021 12:38:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3ajs48w628-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Aug 2021 12:38:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17OCZ4mV55575030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 12:35:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFC72AE055;
        Tue, 24 Aug 2021 12:38:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D899AE061;
        Tue, 24 Aug 2021 12:38:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.88.64])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Aug 2021 12:38:43 +0000 (GMT)
Message-ID: <2c4f61ff68544b2627fc4a38ad1e4109184ec68a.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix deadlock within "ima_match_policy" function.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     liqiong <liqiong@nfschina.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>
Cc:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 24 Aug 2021 08:38:43 -0400
In-Reply-To: <3ba4da9d-fa7b-c486-0c48-67cee4d5de6d@nfschina.com>
References: <20210819101529.28001-1-liqiong@nfschina.com>
         <20210824085747.23604-1-liqiong@nfschina.com>
         <e720e88e-ebfa-56df-6048-f2da0b8fa2a0@viveris.fr>
         <3ba4da9d-fa7b-c486-0c48-67cee4d5de6d@nfschina.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OAF4OJxESa_6v8_XNPYC-lJS3HujDIh8
X-Proofpoint-ORIG-GUID: yIFyAedLM7p_QQFuogEEIoA2Fr4C4qQ8
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-24_02:2021-08-24,2021-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108240084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-08-24 at 20:09 +0800, liqiong wrote:
> Hi Simon :
> 
> ima: fix deadlock within RCU list of ima_rules.
> 

Before the following paragraph, an introductory sentence is needed. 
Try adding a sentence to the affect that "ima_rules" initially points
to the "ima_default_rules", but after loading a custom policy points to
the "ima_policy_rules".   Then describe the bug at a high level,
something like - transitioning to the "ima_policy_rules" isn't being
done safely.

Followed by the details.

> ima_match_policy() is looping on the policy ruleset while
> ima_update_policy() updates the variable "ima_rules". This can
> lead to a situation where ima_match_policy() can't exit the
> 'list_for_each_entry_rcu' loop, causing RCU stalls
> ("rcu_sched detected stall on CPU ...").
> 
> This problem can happen in practice: updating the IMA policy
> in the boot process while systemd-services are being checked.
> 
> In addition to ima_match_policy(), other function with 
> "list_for_each_entry_rcu" should happen too. Fix locking by 
> introducing a duplicate of "ima_rules" for each 
> "list_for_each_entry_rcu".
> 
> 
> How about this commit message ?
> 
> I have tested this patch in lab, we can reproduced this error case, 
> have done reboot test many times. This patch should work. 

The above comment doesn't belong in the commit message, but is a
message to the reviewers/maintainers and goes after the patch
descriptions three dashes line.

thanks,

Mimi

