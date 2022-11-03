Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9E2617E73
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 14:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiKCNyf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKCNye (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 09:54:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D735C774
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 06:54:30 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3DBmgi005092;
        Thu, 3 Nov 2022 13:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EgN3WrDAEgWoAFGq3hIdNfPAu27QMXCQ5sAxjhhhYgk=;
 b=MfY9j2GhRTKo/pBc/r/oXYnGFGe3J92yoxnC05TBxQOH+VKfvR41FuOtLNIOTH6mTKjV
 E676ROkJdaOJe8dP+39R9RxV+6jt7FJ1ILG8EgngrgA29SuOH6yvpGz0Nlw6yx2bEvet
 7imqYQXNBB4XuGlyl4hiUshmTD2T7uvwoODkC87XD9KxrcQg9x170Ox+2RHSIpRieSxr
 LQTLq2Yn0eocmvAFYyQPfyOyffpoXhaRHH9DgZHLLAeAXlqa/UR5Ax08myQnwVuRoH5p
 tFTLCj1BYE7fgwqj/jKxwLpCiZ4rcbWvmUBfqmReSULGQcsUw07fnCmk3mxLkrsdGulH lA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmayvfvt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 13:54:24 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3DpLNa009087;
        Thu, 3 Nov 2022 13:54:23 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 3kgutasyuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 13:54:23 +0000
Received: from smtpav03.dal12v.mail.ibm.com ([9.208.128.129])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3DsJ6J42467666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 13:54:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9840E5806C;
        Thu,  3 Nov 2022 13:54:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4631D5805A;
        Thu,  3 Nov 2022 13:54:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.20.100])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 13:54:21 +0000 (GMT)
Message-ID: <4db89eab7d21124aa7945ccf4fd150c3ee4d259c.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
Date:   Thu, 03 Nov 2022 09:54:20 -0400
In-Reply-To: <52e19952-a1c3-722e-2267-a625e16c37a2@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
         <20221101201803.372652-2-zohar@linux.ibm.com>
         <0a70ffe5-a35a-f8fa-dfa8-be3bf2e5e29f@linux.ibm.com>
         <145f4c70ec894c4980d9455485cdac4673e01d04.camel@linux.ibm.com>
         <52e19952-a1c3-722e-2267-a625e16c37a2@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: osJVOa9-lZ7p0Xlkkw9X_Th0B3hKmXCJ
X-Proofpoint-GUID: osJVOa9-lZ7p0Xlkkw9X_Th0B3hKmXCJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030093
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-11-01 at 20:25 -0400, Stefan Berger wrote:
> 
> On 11/1/22 19:04, Mimi Zohar wrote:
> > Hi Stefan,
> > 
> > On Tue, 2022-11-01 at 17:46 -0400, Stefan Berger wrote:
> >>
> >> On 11/1/22 16:17, Mimi Zohar wrote:
> >>> This reverts commit acb19d1894a4a95471b8d2346cd6c3ecf3385110.
> >>
> >> $ git show acb19d1
> >> fatal: ambiguous argument 'acb19d1': unknown revision or path not in the working tree.
> >>
> >> Are you reverting this from a public tree? or could you just drop this patch from your series?
> >>
> >> Also after removing this patch from the mbox file I cannot apply these patches to my sourceforge checkout -- presumably next-testing branch:
> >>
> >> $ git am ./v4_20221101_zohar_address_deprecated_warnings.mbx
> >> Applying: log and reset 'errno' after failure to open non-critical files
> >> Applying: Log and reset 'errno' on lsetxattr failure
> >> Applying: travis: update dist=focal
> >> Applying: Update configure.ac to address a couple of obsolete warnings
> >> Applying: Deprecate IMA signature version 1
> >> error: patch failed: src/libimaevm.c:684
> >> error: src/libimaevm.c: patch does not apply
> >> Patch failed at 0005 Deprecate IMA signature version 1
> >> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> >> When you have resolved this problem, run "git am --continue".
> >> If you prefer to skip this patch, run "git am --skip" instead.
> >> To restore the original branch and stop patching, run "git am --abort".
> > 
> > Sorry, I should have used "--base=auto" when generating the patch set.
> > Yes, the patch set is based on the github next-testing branch.
> > 
> 
> Is the github repo now the main repo and sourceforge repo is dead?

The "next" branch in both repo's are the same.  Before posting patches,
I verify that github Actions works.   As a result, the next-testing
branch on github is rebased frequently.  Once a patch set is ready, the
"next" branch in both repo's is updated.

To answer your question the github repo is primary.

Mimi

