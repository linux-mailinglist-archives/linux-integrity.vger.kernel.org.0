Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4649130551
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Jan 2020 02:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgAEBSq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Jan 2020 20:18:46 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:8826 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbgAEBSp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Jan 2020 20:18:45 -0500
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0051IY29022683;
        Sun, 5 Jan 2020 01:18:34 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0a-002e3701.pphosted.com with ESMTP id 2xb423rd00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Jan 2020 01:18:34 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 926A4A7;
        Sun,  5 Jan 2020 01:18:33 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (blofly.tw.rdlabs.hpecorp.net [15.119.208.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 6412736;
        Sun,  5 Jan 2020 01:18:31 +0000 (UTC)
Date:   Sun, 5 Jan 2020 09:12:46 +0800
From:   Clay Chang <clayc@hpe.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Subject: Re: [PATCH] ima: Add a space after printing a LSM rule for
 readability
Message-ID: <20200105011246.GA5936@blofly.tw.rdlabs.hpecorp.net>
References: <1578037863-7102-1-git-send-email-clayc@hpe.com>
 <1578071487.5152.13.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1578071487.5152.13.camel@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-04_06:2020-01-02,2020-01-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001050010
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jan 03, 2020 at 12:11:27PM -0500, Mimi Zohar wrote:
> On Fri, 2020-01-03 at 15:51 +0800, clayc@hpe.com wrote:
> > From: Clay Chang <clayc@hpe.com>
> 
> Normally this "From" line is only seen when the sender isn't the patch
> author.  Any ideas what happened? 
>

Hi Mimi,

Apparently I should not use "--from" in git-send-email command.

> > 
> > When reading ima_policy from securityfs, there is a missing
> > space between output string of LSM rules.
> > 
> > Signed-off-by: Clay Chang <clayc@hpe.com>
> 
> Good catch!  IMA policy rules based on LSM labels are used to
> constrain which files are in policy.  Normally a single LSM label is
> enough (e.g. dont_measure obj_type=auditd_log_t).  Could you include
> in this patch description a use case where multiple LSM labels are
> needed?
> 

Apology for not expressed my intention clearly. The intention of this
patch is to add a space after printing LSM rules (if any) and the
remaining rules.

Currently, if I have a policy, for example:
appraise func=BPRM_CHECK obj_type=shell_exec_t appraise_type=imasig

The read back result is:
appraise func=BPRM_CHECK obj_type=shell_exec_tappraise_type=imasig

which is not correct.

I do not have a case for multiple LSM labels, but if there is one
such case, this patch will also apply.

I will post a v2 patch with tuned description.

Thanks,
Clay
