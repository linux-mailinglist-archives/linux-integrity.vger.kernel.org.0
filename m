Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060115A115F
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Aug 2022 15:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbiHYNCt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Aug 2022 09:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242127AbiHYNCl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Aug 2022 09:02:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3D80F42
        for <linux-integrity@vger.kernel.org>; Thu, 25 Aug 2022 06:02:36 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PCqXrj016753;
        Thu, 25 Aug 2022 13:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=XxTLddRjTmoJzFQafDUPnLX+cmJgCce6xWR1x6iCszU=;
 b=CSDtsKdHl0rCA5DdyAxi8woRzKWi/l66wf6WhgIMpzC6xCoPuBAwLt5bd2FR3p65+o/S
 aHihymT417AklxCAFR/wUrlDdH7Lc/6/cpswBf25/8eAYhLCrZe4uf+lN/duE69z4xG6
 kXYcbJUStBooaJBW/6jaUOxIbVBo8k5RhIoTIvR6gZuB7kylM0rZuNBSPstIQFNNWIPc
 5jqceiuobsrDLWXkY0QATWBd1LW7/qxp7tr3T6Qf8ADHdEsNc5q02ZrL4zqdAX2/+I35
 m7dE3C7IfYcIkYotyI8sJl4EDSpjPynjecW03BPY11ThNqDrdFY0evvBxQkF45mpjAIz qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j69f8g99b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 13:02:28 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27PCtKam028541;
        Thu, 25 Aug 2022 13:02:28 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j69f8g98a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 13:02:28 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27PCooQl003384;
        Thu, 25 Aug 2022 13:02:26 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01wdc.us.ibm.com with ESMTP id 3j2q897p5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 13:02:26 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27PD2Qdb56689102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 13:02:26 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73308112062;
        Thu, 25 Aug 2022 13:02:26 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAAEB112061;
        Thu, 25 Aug 2022 13:02:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.119.31])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Aug 2022 13:02:25 +0000 (GMT)
Message-ID: <886d4588b9b6ab4e7dd903addf9809898defd6d9.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Handle -ESTALE returned by ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com
Date:   Thu, 25 Aug 2022 09:02:25 -0400
In-Reply-To: <61bc81bc-1b4a-3c08-6232-afc0d04decee@huawei.com>
References: <20220818020551.18922-1-guozihua@huawei.com>
         <b383f302284dfa31408e2796a9cae60eefd45004.camel@linux.ibm.com>
         <998ca87c-8eef-8d50-e1ee-da53ef8f0046@huawei.com>
         <c61de998f8ed1e1192297f9a2ce568a86cee3296.camel@linux.ibm.com>
         <d5861fbc-1079-a47f-e746-1072dd1d37d7@huawei.com>
         <dc34912b2bad1c46f249fb6e2aa2c79e26890699.camel@linux.ibm.com>
         <6cd55a0f-366f-45b7-d0e5-4116de454c10@huawei.com>
         <117476d4f35be96ddba26675b849af44a5dbd6d1.camel@linux.ibm.com>
         <61bc81bc-1b4a-3c08-6232-afc0d04decee@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sY5k_U2KtGulXZRlCffk0hkzYZcIovik
X-Proofpoint-GUID: Bw2eWp0FUQVPvdm0km91MNrjD4Pk5336
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_05,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=945 spamscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-08-24 at 09:56 +0800, Guozihua (Scott) wrote:
> On 2022/8/24 9:26, Mimi Zohar wrote:
> > On Tue, 2022-08-23 at 21:28 +0800, Guozihua (Scott) wrote:
> >> On 2022/8/23 21:21, Mimi Zohar wrote:
> >>> On Tue, 2022-08-23 at 16:12 +0800, Guozihua (Scott) wrote:
> >>>>> The question is whether we're waiting for the SELinux policy to change
> >>>>> from ESTALE or whether it is the number of SELinux based IMA policy
> >>>>> rules or some combination of the two.  Retrying three times seems to be
> >>>>> random.  If SELinux waited for ESTALE to change, then it would only be
> >>>>> dependent on the time it took to update the SELinux based IMA policy
> >>>>> rules.
> >>>>
> >>>> We are waiting for ima_lsm_update_rules() to finish re-initializing all
> >>>> the LSM based rules.
> >>>
> >>> Fine.  Hopefully retrying a maximum of 3 times is sufficient.
> >>>
> >> Well, at least this should greatly reduce the chance of this issue from
> >> happening.
> > 
> > Agreed
> > 
> >> This would be the best we I can think of without locking and
> >> busy waiting. Maybe we can also add delays before we retry. Maybe you
> >> got any other thought in mind?
> > 
> > Another option would be to re-introduce the equivalent of the "lazy"
> > LSM update on -ESTALE, but without updating the policy rule, as the
> > notifier callback will eventually get to it.
> > 
> 
> For this to happen we would need a way to tell when we are able to 
> continue with the retry though.

Previously with the lazy update, on failure security_filter_rule_init()
was called before the retry.  To avoid locking or detecting when to
continue, another option would be to call to
security_filter_rule_init() with a local copy of the rule.  The retry
would be based on a local copy of the rule.

Eventually the registered callback will complete, so we don't need to
be concerned about updating the actual rules.
-- 
thanks,

Mimi

