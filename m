Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520943EA559
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 15:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhHLNSv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 09:18:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21682 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231384AbhHLNRA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 09:17:00 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CD4E1L020220;
        Thu, 12 Aug 2021 09:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=V4pkCY3azCsZIhd8sdo8SibaFKZKrHFepPl+c/u4pag=;
 b=LF6tpKMzRDv62JfSGVrgfdDCs4kjUFFnNdUlUhWlvqD7V84GqFvmVX7u71jW9A2f249O
 7+gENaHZzLBqHewoTaooG8ZiecWqYmNWRc5Pjsi9gkZdMI+df6na86E1EEC6lYIgEFnA
 osmqXSVpMjriGxJwif01FxPoMVOWS8t+vlyRf6erLSpuxhWik3pSAQJu/glvbdDU1oWH
 EM/ZvKuTLazNA/e//4nh8SaDDGuT9nMG6BnarpMGmSGA42iaik4pw0krQ0yWM/lmzTsb
 1kaRcZfGK2dJXi1aMKzKXYVMIar2mVC/b1z4OHFOu6P2GkQdOKYJe27helZ3kufsr/G2 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3achs76183-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 09:16:32 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17CD55Ra026462;
        Thu, 12 Aug 2021 09:16:32 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3achs76178-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 09:16:32 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17CDBcO4032642;
        Thu, 12 Aug 2021 13:16:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3a9ht90y01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 13:16:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17CDDBcc56885740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 13:13:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7E854203F;
        Thu, 12 Aug 2021 13:16:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E08A42056;
        Thu, 12 Aug 2021 13:16:26 +0000 (GMT)
Received: from sig-9-65-206-218.ibm.com (unknown [9.65.206.218])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Aug 2021 13:16:26 +0000 (GMT)
Message-ID: <c705ef557f40289d58ab7cbab8c2c0e7b888671e.camel@linux.ibm.com>
Subject: Re: [PATCH v7 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Thu, 12 Aug 2021 09:16:25 -0400
In-Reply-To: <023a0ec1-aed7-9862-e0c9-a825d46ade0f@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
         <20210811114037.201887-5-simon.thoby@viveris.fr>
         <84b3a572eb5fc1ec81291656c9f9af00568bff9f.camel@linux.ibm.com>
         <023a0ec1-aed7-9862-e0c9-a825d46ade0f@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O6fblWuai6SQAqUniyg_7ejUQ7DWgNAn
X-Proofpoint-ORIG-GUID: OsbyaqdRdj9-FopYBrWGe0Semeb2arvK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_04:2021-08-12,2021-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Thu, 2021-08-12 at 08:06 +0000, THOBY Simon wrote:
> On 8/11/21 6:26 PM, Mimi Zohar wrote:
> > On Wed, 2021-08-11 at 11:40 +0000, THOBY Simon wrote:
> >> +static unsigned int ima_parse_appraise_algos(char *arg)
> >> +{
> >> +	unsigned int res = 0;
> >> +	int idx;
> >> +	char *token;
> >> +
> >> +	while ((token = strsep(&arg, ",")) != NULL) {
> >> +		idx = match_string(hash_algo_name, HASH_ALGO__LAST, token);
> >> +
> >> +		if (idx < 0) {
> >> +			pr_err("unknown hash algorithm \"%s\"",
> >> +			       token);
> >> +			return 0;
> > 
> > Previous versions of this patch ignored unknown algorithms.  If not all
> > of the algorithms are defined in an older kernel, should loading the
> > policy fail?   As new IMA policy features are defined, older kernels
> > prevent loading newer policies with unknown features.   I hesitated to
> > equate the two scenarios.
> 
> Yes, that choice isn't easy. I changed the behavior in response to Lakshmi's
> remark on v6. It's true that failing to load the policy on an old kernel because
> of an unknown algorithm is not very desirable, but loading a partial policy may
> be worse.

Somehow I missed Lakshmi's comment.  Thank you for the really well
written and thought out explanation below.

> 
> As an exampe, if we load the policy rule
> 	appraise func=BPRM_CHECK fowner=0 appraise_algos=sha256,<new_algo>
> in a version of the kernel that doesn't know about <new_algo>, a permissive interpretation
> would yield
> 	appraise func=BPRM_CHECK fowner=0 appraise_algos=sha256.
> Now if the the system files were already hashes with <new_algo>, then the user is in
> for a world of pain as the system can't boot (trying to appraise every executable root
> owns - that is, pretty much all of them - will fail).
> Admittedly, if the kernel doesn't know about <new_algo>, there is little chances the
> filesystem was protected with that algorithm, unless the user did migrate to <new_algo>
> at some point and is now trying to rollback to an older kernel for some reason.
> So I think that remains a very niche issue.
> 
> 
> On the other hand, rejecting the policy protects against typos and human errors
> (while trying this patch, I once wrote 'appraise [...] appraise_hashes=sha256,sha384;sha512'
> which was accepted and silently updated to 'appraise [...] appraise_hashes=sha256',
> and I didn't understood my error until trying to launch a command and being greeted with the
> infamous "Permission denied". Had I been monitoring the kernel log, I would have seen the error
> right away, but as the policy was accepted I assumed it did what I expected and didn't thought
> any more of it until seeing failures).
> It is also more consistent, as I think it is a desirable feature to know when writing a policy
> to the kernel that reading it back will return the exact same policy, modulo the order of the
> fields in the policy rules. Ignoring unknown algorithms breaks that behavior.
> 
> 
> Additionally, I don't think digest algorithms are added very frequently to the
> kernel (or else the list would be much longer), which mitigate the potential impact
> of either solution.
> 
> 
> After some thought, I am personally inclined to prefer strict checking, as I think failing fast
> and early can save great ordeals later. Of course it's not always easy in the case of the kernel,
> where failure is not an option except in some rare catastrophic situations. But as rejecting
> invalid algorithms is coherent with the IMA behavior with regard to new features, and rejecting
> a policy cannot break a system (although it definitely reduces the trust you can have in the
> integrity of the system), I think that's an acceptable behavior.
> 
> > 
> >> +		}
> >> +
> >> +		/* Add the hash algorithm to the 'allowed' bitfield */
> >> +		res |= (1U << idx);
> > 
> > This assumes that all the hash algorithms are enabled in the kernel,
> > but nothing checks that they are.  In validate_hash_algo(), either the
> > allowed_hashes is checked or the hash algorithm must be configured.  Do
> > we really want a total separation like this?
> 
> I kind of assumed that if the user allowlist some algorithms with 'appraise_algos', he is basically
> saying "I know what I'm doing, trust these values", and thus these values take precedence on
> the algorithms compiled in the kernel.

Agreed, but having this discussion is important too.

> 
> In addition, validate_hash_algo() is only ever used for setxattr, not for appraisal
> (which is the subject of this specific patch). If a user try to run a file appraised
> with an algorithm not present in the kernel, ima_collect_measurement() would fail
> before we even checked that the algorithm is in the allowlist (process_measurement()->
> ima_collect_measurement()->ima_calc_file_hash()->ima_calc_file_ahash()->ima_alloc_atfm(<algo>)
> would fail and log an error message like "Can not allocate <algo> (reason: <result>)").
> So that check is already done "for free" on appraisal.
> 
> However your comment does applies to the next patch ("IMA: introduce a new policy
> option func=SETXATTR_CHECK"), and we probably could restrict the algorithms referenced in
> ima_setxattr_allowed_hash_algorithms to ones the current kernel can use. 
> The easiest way to enforce this would probably be to check that when parsing 'appraise_algos'
> in ima_parse_appraise_algos(), we only add algorithms that are available, ignoring - or
> rejecting, according to the outcome of the discussion above - the other algorithms. That way,
> we do not have to pay the price of allocating a hash object every time validate_hash_algo() is
> called.
> 
> Would it be ok if I did that?

Without knowing and understanding all the environments in which IMA is
enabled (e.g. front end, back end build system), you're correct -
protecting the user from themselves -might not be the right answer.

What you suggested, above, would be the correct solution.  Perhaps post
that change as a separate patch, on top of this patch set, for
additional discussion.

thanks,

Mimi

