Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACCB3F9C44
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Aug 2021 18:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245389AbhH0QRS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 27 Aug 2021 12:17:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234192AbhH0QRR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Aug 2021 12:17:17 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17RG434C127152;
        Fri, 27 Aug 2021 12:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nvvnLdxHi7PTLSadgbA728cuJKrqqjfzeSllbtHLFwg=;
 b=bRPh6DXN+iqWxDAajTfq6mvDn+33+aHUbZnVandpm/87hKnEFu8yXu0nu0O0S5TEAuW3
 PAZDoBT4LJO4W6Mib3dQUamET3aU4CoJKn7xjrs+FJJIxQFjObzLqpW/x0J2hbGG48J0
 km3554ftQX9bCS2eKmnW6IXgyMAbaRoQCr0pib97XG7NhFxWxARhEMMUtqFGsS3B5lyP
 g0XIqnUOWTrff3jrPKE9j7txvP7jbFnztybJMVa01MK8BwJtLse+ParcOYPVfKfz6lG4
 dyp0P3pFaAJhBcWYP8hyz4uyxtQWhFw0L3WzdRFUl1YCgZpWE/zTe16eSjKLX545b5cm 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aq36n8fpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 12:16:14 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17RG47jM127343;
        Fri, 27 Aug 2021 12:16:13 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aq36n8fnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 12:16:13 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17RGDauT026077;
        Fri, 27 Aug 2021 16:16:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ajs48kshj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Aug 2021 16:16:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17RGG8bM56754632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 16:16:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE2FE52063;
        Fri, 27 Aug 2021 16:16:08 +0000 (GMT)
Received: from sig-9-65-233-113.ibm.com (unknown [9.65.233.113])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 281AE5204E;
        Fri, 27 Aug 2021 16:16:06 +0000 (GMT)
Message-ID: <f1953b977c3bcce8cfb4b25355e4c6d52820b7ea.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix deadlock when traversing "ima_default_rules".
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     liqiong <liqiong@nfschina.com>, Simon.THOBY@viveris.fr
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Aug 2021 12:16:06 -0400
In-Reply-To: <20210827103536.4149-1-liqiong@nfschina.com>
References: <20210824085747.23604-1-liqiong@nfschina.com>
         <20210827103536.4149-1-liqiong@nfschina.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rFWXgPAAdNyGze5lqKH2wWr8KROvEFWO
X-Proofpoint-ORIG-GUID: XT8JGzVNTy6U3pv_9f6kFkeNfTDlgHLF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_04:2021-08-26,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-08-27 at 18:35 +0800, liqiong wrote:
> The current IMA ruleset is identified by the variable "ima_rules"
> that default to "&ima_default_rules". When loading a custom policy
> for the first time, the variable is updated to "&ima_policy_rules"
> instead. That update isn't RCU-safe, and deadlocks are possible.
> Indeed, some functions like ima_match_policy() may loop indefinitely
> when traversing "ima_default_rules" with list_for_each_entry_rcu().
> 
> When iterating over the default ruleset back to head, if the list
> head is "ima_default_rules", and "ima_rules" have been updated to
> "&ima_policy_rules", the loop condition (&entry->list != ima_rules)
> stays always true, traversing won't terminate, causing a soft lockup
> and RCU stalls.
> 
> Introduce a temporary value for "ima_rules" when iterating over
> the ruleset to avoid the deadlocks.
> 
> Signed-off-by: liqiong <liqiong@nfschina.com>
> Reviewed-by: THOBY Simon <Simon.THOBY@viveris.fr>

Thank you, Liqiong, Simon.   This patch set is now queued in the next-
integrity-testing 
branch.

Mimi

