Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DCB5A58DE
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 03:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiH3BUl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Aug 2022 21:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiH3BUk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Aug 2022 21:20:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9905E317
        for <linux-integrity@vger.kernel.org>; Mon, 29 Aug 2022 18:20:39 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U1I0PQ005681;
        Tue, 30 Aug 2022 01:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=gUzxpSxuMNKWcMgs76XXpDO+KCUwY0J8ozbxwf30rJ8=;
 b=igZcbwsEIXYzZVpR0EkJl8nVxkeK3EYkvYcyd/Ue2gQjckH6nDzdl/gdq49VbS0Oh3G7
 yNhRet/DmBs7Gt5viqu6UbcTDoGNUFdlnMkpZ9NmXEvr48isSed3s8KCJcqNhkw50+wO
 ncH9KVnC8cGFXsRViUUy7pnk/VYnBuSumYGOXnewvqyNVYRL8wS5Us2+Tnnss36kTt3s
 N2E3TkythYmKQXVOKe7hWQyTid3+Fafb90bE4QUY31A9g7Xl/+zjU1VM6cLYOrZZ4MLb
 DMAVy20rYyS6NPmVfsIxZLLCyIMaXZm0cZBhsosIIPHRbTzNy/DnqWCqIIC8OwQYdYBz ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j98s1034n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 01:20:31 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27U1IQMJ006453;
        Tue, 30 Aug 2022 01:20:31 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j98s10345-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 01:20:31 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U15F8r008433;
        Tue, 30 Aug 2022 01:20:31 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 3j7aw9gn8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 01:20:30 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U1KUNQ10158784
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 01:20:30 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45EB5BE053;
        Tue, 30 Aug 2022 01:24:52 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1464BE051;
        Tue, 30 Aug 2022 01:24:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.117.120])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 01:24:51 +0000 (GMT)
Message-ID: <9da1b1ab4a0e75f717c78ff44d985318a955ccd7.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Handle -ESTALE returned by ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com
Date:   Mon, 29 Aug 2022 21:20:29 -0400
In-Reply-To: <d967a934-ba41-1a6d-4dcb-26d715b941b2@huawei.com>
References: <20220818020551.18922-1-guozihua@huawei.com>
         <b383f302284dfa31408e2796a9cae60eefd45004.camel@linux.ibm.com>
         <998ca87c-8eef-8d50-e1ee-da53ef8f0046@huawei.com>
         <c61de998f8ed1e1192297f9a2ce568a86cee3296.camel@linux.ibm.com>
         <d5861fbc-1079-a47f-e746-1072dd1d37d7@huawei.com>
         <dc34912b2bad1c46f249fb6e2aa2c79e26890699.camel@linux.ibm.com>
         <6cd55a0f-366f-45b7-d0e5-4116de454c10@huawei.com>
         <117476d4f35be96ddba26675b849af44a5dbd6d1.camel@linux.ibm.com>
         <61bc81bc-1b4a-3c08-6232-afc0d04decee@huawei.com>
         <886d4588b9b6ab4e7dd903addf9809898defd6d9.camel@linux.ibm.com>
         <d967a934-ba41-1a6d-4dcb-26d715b941b2@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ShGL4LYZNDD-Z0ngIo5Y3oMx5xi22NiN
X-Proofpoint-ORIG-GUID: 1VSKuS-DhlL4i2OzZxQsmhtYaHldgNvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300002
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2022-08-27 at 17:57 +0800, Guozihua (Scott) wrote:
> On 2022/8/25 21:02, Mimi Zohar wrote:
> > On Wed, 2022-08-24 at 09:56 +0800, Guozihua (Scott) wrote:
> >> On 2022/8/24 9:26, Mimi Zohar wrote:
> >>> On Tue, 2022-08-23 at 21:28 +0800, Guozihua (Scott) wrote:
> >>>> On 2022/8/23 21:21, Mimi Zohar wrote:
> >>>>> On Tue, 2022-08-23 at 16:12 +0800, Guozihua (Scott) wrote:
> >>>>>>> The question is whether we're waiting for the SELinux policy to change
> >>>>>>> from ESTALE or whether it is the number of SELinux based IMA policy
> >>>>>>> rules or some combination of the two.  Retrying three times seems to be
> >>>>>>> random.  If SELinux waited for ESTALE to change, then it would only be
> >>>>>>> dependent on the time it took to update the SELinux based IMA policy
> >>>>>>> rules.
> >>>>>>
> >>>>>> We are waiting for ima_lsm_update_rules() to finish re-initializing all
> >>>>>> the LSM based rules.
> >>>>>
> >>>>> Fine.  Hopefully retrying a maximum of 3 times is sufficient.
> >>>>>
> >>>> Well, at least this should greatly reduce the chance of this issue from
> >>>> happening.
> >>>
> >>> Agreed
> >>>
> >>>> This would be the best we I can think of without locking and
> >>>> busy waiting. Maybe we can also add delays before we retry. Maybe you
> >>>> got any other thought in mind?
> >>>
> >>> Another option would be to re-introduce the equivalent of the "lazy"
> >>> LSM update on -ESTALE, but without updating the policy rule, as the
> >>> notifier callback will eventually get to it.
> >>>
> >>
> >> For this to happen we would need a way to tell when we are able to
> >> continue with the retry though.
> > 
> > Previously with the lazy update, on failure security_filter_rule_init()
> > was called before the retry.  To avoid locking or detecting when to
> > continue, another option would be to call to
> > security_filter_rule_init() with a local copy of the rule.  The retry
> > would be based on a local copy of the rule.
> > 
> > Eventually the registered callback will complete, so we don't need to
> > be concerned about updating the actual rules.
> 
> Is it possible to cause race condition though? With this, the notifier 
> path seems to be unnecessary.

I don't see how there would be a race condition.  The notifier callback
is the normal method of updating the policy rules.  Hopefully -ESTALE
isn't something that happens frequently.
-- 
thanks,

Mimi

