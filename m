Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651DD3DA8A9
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jul 2021 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhG2QQG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jul 2021 12:16:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14814 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhG2QQF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 12:16:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TG3ODf195532;
        Thu, 29 Jul 2021 12:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=jfpoF8lZhvSnApdR5QNNmgSoD/vX4e/7W/gfUyukGGc=;
 b=nWhbmc7fExOkZPBkXOOlgTSmAVYMStfBpxjR3+Vw6VtYOIAS2S1DxaUBfovu3dFPGzJN
 AEzo8DZmsfmMW+ltrd559nW9qdL1ZR5LChq1NfYyI1y/Gb0NCDniICUz0NnZOMye/Tpx
 /vceBMZLG+j/D18s2hXut5RJ1Hz+Ly6vS+hgUBzPxcQy7Axk7FaEM5a0bbJyCr03Qnf3
 o2UNvpK4cZDiOgDorPsgwcd54QgQPqBooF9kjkkNM5cSNgBZlxaMz7pALKuDkEwNP/LL
 pgu1ORd/TjxU8xER+ggoImfoGRrZ1fTO9xPLqMbKH19MwxvXwHDTmo7K7QBT66r9kMWH mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3xu82dqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 12:16:01 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16TG3mfF001027;
        Thu, 29 Jul 2021 12:16:01 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3xu82dpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 12:16:01 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TGCiUG026278;
        Thu, 29 Jul 2021 16:15:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3a235khx92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 16:15:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TGDFiK26476932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 16:13:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5597442047;
        Thu, 29 Jul 2021 16:15:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3689E42057;
        Thu, 29 Jul 2021 16:15:56 +0000 (GMT)
Received: from sig-9-65-212-145.ibm.com (unknown [9.65.212.145])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jul 2021 16:15:55 +0000 (GMT)
Message-ID: <07dced7b64c88b3212a8539da8e10450d62704dd.camel@linux.ibm.com>
Subject: Re: [PATCH v5 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Thu, 29 Jul 2021 12:15:55 -0400
In-Reply-To: <1fdf70ea-a5db-75d5-3e33-71229fcfd31d@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
         <20210728132112.258606-6-simon.thoby@viveris.fr>
         <acf4fc349a59b4390e0ff57728f8f4920f89386a.camel@linux.ibm.com>
         <1fdf70ea-a5db-75d5-3e33-71229fcfd31d@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VySOcQmwfAG87fSXa8cdVt9Xo8_Heuqs
X-Proofpoint-ORIG-GUID: USdFgYApfeUVCJxCbskS3DSIqoothJPt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Thu, 2021-07-29 at 07:47 +0000, THOBY Simon wrote:
> 
> >> + * for setxattr writes
> >> + *
> >> + * Update the atomic variable holding the set of allowed hash algorithms
> >> + * that can be used to update the security.ima xattr of a file.
> >> + *
> >> + * Context: called when updating the IMA policy.
> >> + *
> >> + * SETXATTR_CHECK rules do not implement a full policy check because of
> >> + * the performance impact performing rules checking on setxattr() would
> >> + * have. The consequence is that only one SETXATTR_CHECK can be active at
> >> + * a time.
> >> + */
> >> +static void update_allowed_hash_algorithms(void)
> >> +{
> >> +	struct ima_rule_entry *entry;
> >> +
> >> +	/*
> >> +	 * We scan in reverse order because only the last entry with the
> >> +	 * 'func=SETXATTR_CHECK' apply: this allows runtime upgrades of the
> >> +	 * digest algorithm policy, unlike the other IMA rules that are
> >> +	 * usually append-only. Old rules will still be present in the
> >> +	 * ruleset, but inactive.
> >> +	 */
> > 
> > Oh, my!  I really hope this won't be used as precedent.  Before
> > agreeing to this, the existing policy rules must require loading of
> > only signed IMA policies.
> > 
> 
> 
> After some though, I think you're right, there is not much point to do anything
> different from the other IMA rules, 
> 
> Below is the modified version that I will submit in the next patch.
> 
> However given the similarities between this function and ima_update_policy_flag,
> I think maybe I should merge them together: they are mostly called from the
> same places and they both serve the same role: updating some of the global ima
> variables after a policy update or at system initialization.
> 
> Do you think it would be ok to add that functionality to ima_update_policy_flag?
> Maybe updating the name to reflect that the function updates multiples flags?

We've gone through a couple of iterations of this patch.  At this
point, it's defining a single set of setxattr permitted hash
algorithms.  Renaming and adding the change to
ima_update_policy_flags() definitely makes sense.

At the same time, I'd appreciate your fixing the RCU locking there.

> As a side note on the patchset, maybe I should refrain from posting for a few days to give people time
> to comment on it, instead of sending new versions in such a quick succession?

Definitely.

thanks,

Mimi

