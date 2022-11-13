Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F456272B4
	for <lists+linux-integrity@lfdr.de>; Sun, 13 Nov 2022 22:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiKMV0H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 16:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiKMV0G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 16:26:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A1EB7F7
        for <linux-integrity@vger.kernel.org>; Sun, 13 Nov 2022 13:26:03 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2ADL3pcu006283;
        Sun, 13 Nov 2022 21:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=L7Ohkd7+ZO05xeU9Ke8KXW9HL4sXk4WR41/3fhPDM0g=;
 b=GMK9TjM+OHW5KRtETHd6AE9TKwiX6DY7uK+XptVD/P6d2j+bOZ63FrKRTzBiBMOCba1H
 efvTsk2ROuNkvy7gscpAfclZH6/oT8DfIacrkh1wjnyiI1YNGW+I/STkAksDUo4XSQWZ
 lJlxeeuGR8FxNSNR8kEbc15wygftahga7x01hN8jjjEZ1OIAcxdTxmleZxP4HKoq4ZZY
 jUMdR7FKJbtVLAaQwhS1LLpPOt4TB4sunEhWy559oCj8B6Z2MnArLXfXAMbdPZkC0beM
 LelfV7MG9z7Egw8Hm1nOs+/oDEJukYCmLAOZ6IyFt2EHp7dt9kSlDjFqUJtJ69fE9LXn TA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ku85u09k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 21:25:57 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ADLLKiK010427;
        Sun, 13 Nov 2022 21:25:56 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3kt349c9np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 21:25:56 +0000
Received: from smtpav01.wdc07v.mail.ibm.com ([9.208.128.113])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ADLPtOX9437764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 21:25:56 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40D5758055;
        Sun, 13 Nov 2022 21:25:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC7E55804B;
        Sun, 13 Nov 2022 21:25:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.91.8])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 13 Nov 2022 21:25:54 +0000 (GMT)
Message-ID: <84e0ecce227a93ec167563d0892a344c0b9043a9.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v4 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Petr Vorel <pvorel@suse.cz>, Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Sun, 13 Nov 2022 16:25:54 -0500
In-Reply-To: <20221103225049.6u7xxgn3tk66n3ez@altlinux.org>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
         <20221101201803.372652-2-zohar@linux.ibm.com>
         <0a70ffe5-a35a-f8fa-dfa8-be3bf2e5e29f@linux.ibm.com>
         <145f4c70ec894c4980d9455485cdac4673e01d04.camel@linux.ibm.com>
         <52e19952-a1c3-722e-2267-a625e16c37a2@linux.ibm.com>
         <4db89eab7d21124aa7945ccf4fd150c3ee4d259c.camel@linux.ibm.com>
         <Y2PREKTdNQhwhPEK@pevik>
         <6641d0eec7dd91d0d8b2f5dbf1844173a79b13fe.camel@linux.ibm.com>
         <20221103225049.6u7xxgn3tk66n3ez@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9fKJ7OoMpksEpL4SICz8tW83aiOdnye3
X-Proofpoint-ORIG-GUID: 9fKJ7OoMpksEpL4SICz8tW83aiOdnye3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_14,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211130146
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-11-04 at 01:50 +0300, Vitaly Chikunov wrote:
> On Thu, Nov 03, 2022 at 05:35:40PM -0400, Mimi Zohar wrote:
> > Hi Petr,
> > 
> > > > > Is the github repo now the main repo and sourceforge repo is dead?
> > > 
> > > > The "next" branch in both repo's are the same.  Before posting patches,
> > > > I verify that github Actions works.   As a result, the next-testing
> > > > branch on github is rebased frequently.  Once a patch set is ready, the
> > > > "next" branch in both repo's is updated.
> > > 
> > > > To answer your question the github repo is primary.
> > > Maybe deleting everything in sourceforge and ad put single file with link to
> > > github.com would save you work (having master, next and next-testing branches
> > > with this file).
> > 
> > Thanks, definitely appreciate time saving tips!  Vitaly suggested
> > saving the sourceforge wiki info in ima-evm-utils and updating the
> > file(s) like any other file.  Before removing "everything"h from
> > sourceforge, that still needs to be done.
> 
> I thought markdown should be downloaded from Edit interface, which is not
> available on SF for non-admins. But I found recently hbow to download it
> in Json format via Allura API:
> 
>   curl -s https://sourceforge.net/rest/p/linux-ima/wiki/Home  | jq -r .text
> 
> Then only end-of-lines need to be fixed.

There's an admin option to export the wiki, but this is much better.
-- 
thanks,

Mimi


