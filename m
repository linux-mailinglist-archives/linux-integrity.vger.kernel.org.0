Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FB241E261
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 21:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhI3TtG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 15:49:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229777AbhI3TtF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 15:49:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UIUK77021687;
        Thu, 30 Sep 2021 15:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=wtYkkniQkowSl9E85q/Rimm24f70m1X2dA/jUMvBrMA=;
 b=cDSzvhcWQU1QbWAfhGLjbc5TWlScDwgk1AadYvR/wgQ1R0xtQlAxDGrL5sXBkZhm/lRr
 U5Rx56YCgYY56vgv2oQbpKBtmQoCyH9D3qEwCpK577n6p3fcPUkn4vaYK0/zblbs6hHk
 OMUrx1hVIZPV+R9K58hIigFgtNzZcbTMbPoCKG0L8wZjEM0j1RpLBlj9ZAcvj2wt9soU
 iXwffUlRXw84Fic6KTHczxobu1OYbBLGqrH5dmPA2zFdX2DCmGLSMJb7pPLSl5vPMW7L
 phqYr4+z1bikZQfHiHfGDchi5z7zsFUIde4/xGipVny4OtGJXmBWWFMjoUS6bvbY0Us7 cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bdjjxsjv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 15:47:03 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18UJl2C9024728;
        Thu, 30 Sep 2021 15:47:02 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bdjjxsjun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 15:47:02 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18UJhH1r013672;
        Thu, 30 Sep 2021 19:46:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3b9u1km8cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 19:46:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18UJfpQU50200858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 19:41:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DFAAA4040;
        Thu, 30 Sep 2021 19:46:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C3FCA4065;
        Thu, 30 Sep 2021 19:46:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.140.113])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Sep 2021 19:46:55 +0000 (GMT)
Message-ID: <7222772aed3bf4651dc4ed580ade3e6bd33b253d.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: fix deadlock when traversing "ima_default_rules".
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     liqiong <liqiong@nfschina.com>, Simon.THOBY@viveris.fr
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 30 Sep 2021 15:46:52 -0400
In-Reply-To: <20210918031139.22674-1-liqiong@nfschina.com>
References: <20210827103536.4149-1-liqiong@nfschina.com>
         <20210918031139.22674-1-liqiong@nfschina.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -QdY3w3L2IO6evts99gy8Z-XWxegSFBM
X-Proofpoint-GUID: 8yvKQxTXdijSxQ18ikb1NVDTCuO_NHrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_06,2021-09-30_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=951 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Liqiong,

On Sat, 2021-09-18 at 11:11 +0800, liqiong wrote:
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
> Fixes: 38d859f991f3 ("IMA: policy can now be updated multiple times")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Fix sparse: incompatible types in comparison expression.

The "Fix sparse" line shouldn't be on a separate line.  Either post the
one line fix as a separate patch using the normal "Fixes:" tag or fix
the "Reported-by" line, as previously suggested.

thanks,

Mimi

