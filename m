Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BF93D8EB0
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 15:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbhG1NMp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 09:12:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235204AbhG1NMo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 09:12:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SD4T07149258;
        Wed, 28 Jul 2021 09:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fHUwDChCJYjFAgC978DfDS4s4aeIat7P9gQuve3jNcU=;
 b=kSN1eK/ODx4VliLj33Sm/ynonfIav9EgwbLEzMEiUqrx8QumcVOrKyyyYVLLzqFflpoy
 ocbATC1eHMwS896HaXBIuQ7D6LwnfNAe06ZVAu7RqHaTqn0nMPyPAi8dGmq4u+gS3weA
 aKwzTal4ypYINv4pwrwRIQdnZ+luDA2Lj6o2LQY5Em/HDf0HvZmPEVkQHSyFhPjUYwrR
 zyOU4/Wuf2vMCR6JskX/qz1zt+LZU4oHV8Ni9rMRVgh0TZjbPwdfjT4sVEP66uE675wB
 yu6IdfuM7tPsrsLcdIAIh30gFHIsmx7Hwc0YtZhE93eUQGtj7XnxcvOhE/LNV96mA02/ Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a37rv8rf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 09:12:36 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SD4hLk151273;
        Wed, 28 Jul 2021 09:11:37 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a37rv8nx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 09:11:37 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SD9KoK002807;
        Wed, 28 Jul 2021 13:09:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3a235xrq03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 13:09:44 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SD9fpM28049786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 13:09:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AFE7A4068;
        Wed, 28 Jul 2021 13:09:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AA83A405F;
        Wed, 28 Jul 2021 13:09:40 +0000 (GMT)
Received: from sig-9-65-219-1.ibm.com (unknown [9.65.219.1])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 13:09:39 +0000 (GMT)
Message-ID: <b5b2fa45ead2a40e1200ed7414fbae75255d9281.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Cc:     Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Jul 2021 09:09:39 -0400
In-Reply-To: <7bc627f3-a3bb-1cf4-44dc-097b241ac7ad@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
         <20210727163330.790010-3-simon.thoby@viveris.fr>
         <5a3a35b5f20fb17f7430046b0378e05f1dffa098.camel@linux.ibm.com>
         <529bc35e-642f-9f50-f3a7-0d3c07890afe@viveris.fr>
         <3a576c8f562201f441a72bb7232c4bb0faa36318.camel@linux.ibm.com>
         <7bc627f3-a3bb-1cf4-44dc-097b241ac7ad@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dLZUuyS6MIOWtaWbSWRtZQeyr-eBIdxf
X-Proofpoint-ORIG-GUID: Q_OAxXahIjZwE0_cEMVqUbxJRmQOMnFL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280074
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-07-28 at 12:53 +0000, THOBY Simon wrote:
> Hi Mimi,
> 
> On 7/28/21 2:43 PM, Mimi Zohar wrote:
> > Hi Simon,
> > 
> > On Wed, 2021-07-28 at 07:00 +0000, THOBY Simon wrote: 
> >>>> +
> >>>> +	if (likely(dentry_hash == ima_hash_algo
> >>>> +	    || crypto_has_alg(hash_algo_name[dentry_hash], 0, 0)))
> >>>> +		return 0;
> >>>> +
> >>>> +	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> >>>> +	/* no memory available ? no file path for you */
> >>>
> >>> The comment here is unnecessary.  Avoid or limit comments inside a
> >>> function.  Refer to the section "8) Commenting" in
> >>> Documentation/process/coding-style.rst
> >>>
> >>>> +	if (pathbuf)
> >>>> +		path = dentry_path(dentry, pathbuf, PATH_MAX);
> >>>> +
> >>>> +	/* disallow xattr writes with algorithms not built in the kernel */
> >>>> +	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
> >>>> +		path, "collect_data", "unavailable-hash-algorithm", res, 0);
> >>>
> >>> This will emit an audit message without the filename when !path.  Is
> >>> this what you intended?
> >>>
> >>
> >> This is what I was clumsily trying to explain in the previous comment: if we cannot
> >> allocate memory for a file path, I thought it best to log the audit message without
> >> the path than fail with a -ENOMEM (auditing will also try to allocate a memory buffer
> >> too, but a bit smaller, and memory could have been reclaimed between the two calls,
> >> so the auditing operation may succeed).
> >>
> >> Of course I could also return -ENOMEM, and it would happily propagate back to the user.
> >>
> >> What do you think ?
> > 
> > Memory pressure isn't the reason for preventing the xattr write.  It's
> > the reason for not being able to audit the setxattr failure.

Return the existing errno, not -ENOMEM.

> 
> I completely agree with you, but I'm not quite sure I get the action you want to take
> from there.
> Does this mean you prefer the mechanism already implemented in this patch (not printing
> the file path and trying to audit the setxattr failure anyway)?

Under memory pressure, I don't think partially auditing the setxattr,
without the pathname, makes sense.   Not being able to audit the
setxattr failure shouldn't affect the returned result.  It would be the
same in either case.

   if (pathbuf) {
      < audit message >
      < free pathbuf >
   }

   return <failure>

thanks,

Mimi


