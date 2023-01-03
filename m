Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3E965C416
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Jan 2023 17:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjACQhw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Jan 2023 11:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjACQhu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Jan 2023 11:37:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E1EE032
        for <linux-integrity@vger.kernel.org>; Tue,  3 Jan 2023 08:37:49 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303F9vNC024034;
        Tue, 3 Jan 2023 16:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=a85gLFutX++KJY2V2/sOnW9zF/B2rFceRAdmxfYefiE=;
 b=H5DCyTRHS2KttvPSOxD6wIDEGZfw9vV0BiIQ0Wn1VKLWvmoNHSQRLGCD7S1pmh5SuNFN
 gNczJlyPsVxvssEiFgFGY5CiQIwjomnp3N9Z05fFi3ahGd79nT0bjMl1JhD1yG4wzVRO
 YVE2dPzi0VMwjxCnR5n98CQKWJG+H9Ecqt8J58BmX8yExnZqfn8b5FrcE2IU0vHV0cbc
 E7hSlp82BmAO5L+OWgq16Bc6lx6n01KrgfUbKgnVCVwA93iNsXtfEw4xjOV+U93s6xGG
 65m5YKu0HuzxlYF1Nx2JLlkCQppvIXgwruiOq17D49J8zAhAp1RJaoFQjDh6KSYNlpMy Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvhh4hqwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 16:37:48 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 303GEtuQ016305;
        Tue, 3 Jan 2023 16:37:47 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvhh4hqw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 16:37:47 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303FR50P026279;
        Tue, 3 Jan 2023 16:37:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3mtcq72t4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 16:37:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 303Gbjks7930482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 16:37:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FA6858063;
        Tue,  3 Jan 2023 16:37:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A22A058057;
        Tue,  3 Jan 2023 16:37:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.32.150])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jan 2023 16:37:44 +0000 (GMT)
Message-ID: <f08ddfd2dd5f2afe0e8844354c50557f6dc1bf8b.camel@linux.ibm.com>
Subject: Re: ima: zeroed out digest values
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matt Bobrowski <mattbobrowski@google.com>,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, paul@paul-moore.com,
        eparis@redhat.com
Date:   Tue, 03 Jan 2023 11:37:44 -0500
In-Reply-To: <Y7PABtHq14jMGrgK@google.com>
References: <Y7PABtHq14jMGrgK@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: InY-Vjp1O8nJtgOwr8Q-UhWqwJP_4e5v
X-Proofpoint-GUID: Dmxih_jeXJgcWc85O6eD9KURyMLJUAyU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-01-03 at 05:41 +0000, Matt Bobrowski wrote:
> Hi Mimi/Dmitry,
> 
> In commit 54f03916fb892 [0] the way which errors [1, 2] are being
> handled by some of the IMA measurement routines had slightly
> changed. Specifically, in the ima_collect_measurement() helper if the
> hash calculation failed for whatever reason (i.e. received a software
> interrupt whilst executing in a late stage of the ima_bprm_check
> security hook), rather than returning to the caller early we continue
> with populating the ima_digest_data within the respective iint entry,
> in which case is all zeroes given that we initialize the hash buffer
> with zeroes prior to calculating a hash. Some interfaces that piggy
> back of IMA measurements i.e. BPF and Audit, are now left with
> reporting zeroed hash values in some cases.
> 
> I wanted to confirm whether this is expected behavior?

Definitely not.  Thank you for finding and reporting it.

Mimi

> 
> [0]
> https://github.com/torvalds/linux/commit/54f03916fb892441f9a9b579db9ad7925cdeb395
> [1] https://github.com/torvalds/linux/commit/54f03916fb892441f9a9b579db9ad7925cdeb395#diff-a7813ab229aa21485d06aed8f7f36aef97e38d8a0b18a77ecccd64c9abe91194L254
> [2] https://github.com/torvalds/linux/commit/54f03916fb892441f9a9b579db9ad7925cdeb395#diff-7fb0c7b8604559abf88f1313cd798710a86e2f0fa2fab3b0f32bc7972c82846fL338
> 
> /M




