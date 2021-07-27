Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1428A3D80DB
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhG0VH7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 17:07:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27034 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234329AbhG0VHa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 17:07:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RL3neA023155;
        Tue, 27 Jul 2021 17:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=c43xiIAYf3zvKdib4A+qAcmFYJ/2T9RhJCpY6waYEAo=;
 b=ky13myUxtZnmBSNgq9kuSxHpb8IM9+FKaRj77sn0HbEyFuMFiCyKTPALYDk0WQ/O42oN
 mNKNgm1lh7qafa/E8+IPZ5kM/QF3YagpRv7+lZfoIMvnU2BjpxtN8/BGtDN4sth7uVWc
 5mhFe74YeQF6jIF7E/6HEXTXNRzWAy0dY1pQljXgkD4PSbH8x8RMFLNxsdPQDvxbRbmB
 VOw3eVKlWdENHDOGnHnyFy+8WWnUKk8Y4lkmNJbAhlGfmufaQOdN9mWAE6kuFvuwJ51o
 KHUDfwB0YMi0+T0mu3AJooPRn4hazliXCrVXpdwwJLLjQgdGFTrJFwuV+IA29Y1vwnYa mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a2sepgmb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 17:07:30 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RL4FiY025139;
        Tue, 27 Jul 2021 17:07:29 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a2sepgm9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 17:07:29 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RL2ckv026894;
        Tue, 27 Jul 2021 21:07:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3a235kgneu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 21:07:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RL4i0t24445330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 21:04:44 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCE7A11C04A;
        Tue, 27 Jul 2021 21:07:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8069611C04C;
        Tue, 27 Jul 2021 21:07:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.85.52])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jul 2021 21:07:23 +0000 (GMT)
Message-ID: <ecd666bdd278a0ca28b5fec10f4ac06932911f12.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Tue, 27 Jul 2021 17:07:22 -0400
In-Reply-To: <20210727163330.790010-5-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
         <20210727163330.790010-5-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: e55x9JTxOsnCBI7YNev3mPilpNYYbkgF
X-Proofpoint-GUID: bRMeVIb2dyqHdl_aPK2fBFtepSsS5wBg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_14:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270119
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-07-27 at 16:33 +0000, THOBY Simon wrote:
> The kernel have the ability to restrict the set of hash algorithms

^kernel has

> it accepts for the security.ima xattr when it appraises files.
> 
> Define a new IMA policy rule option "appraise_hash=",
> using the mentionned mechanism to expose a user-toggable policy

^mentioned

> knob to opt-in to that restriction and select the desired set of
> algorithms that must be accepted.
> 
> When a policy rule uses the 'appraise_hash' option, appraisal of a
> file referenced by that rule will now fail if the digest algorithm
> employed to hash the file was not one of those explicitly listed
> in the option. In its absence, any hash algorithm compiled in the
> kernel will be accepted.
> 
> For example, on a system where SELinux is properly deployed, the rule
>   appraise func=BPRM_CHECK obj_type=iptables_exec_t appraise_hash=sha256,sha384
> will block the execution of iptables if the xattr security.ima of its
> executables were not hashed with either sha256 or sha384.
> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---

<snip>

> @@ -1204,6 +1228,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  	entry->uid_op = &uid_eq;
>  	entry->fowner_op = &uid_eq;
>  	entry->action = UNKNOWN;
> +	entry->allowed_hashes = 0;

"entry" is zeroed when allocated.

