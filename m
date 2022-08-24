Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E8C59F0E4
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Aug 2022 03:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiHXB1E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiHXB1A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 21:27:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EED8A7FC
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 18:26:56 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O1F5NN013666;
        Wed, 24 Aug 2022 01:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=Xo3pho08sm5NxkKEPzoMphumRGKzljB0axerm0o7Yy0=;
 b=TKGS0RG8PK02xa66NJLC5VuCcscckakvpnrAImO+rFQ0623G3bJRAaCTKIMy2HQyAiwc
 oD6KZt62gpYIrBBCn3dFPc8lhbRDgfxr1jjm9nPLBMFNA7hU+m/SEbE6vchL1v76jbjy
 FPGL+LF4WDNR1hnWPwGRl33nwSkUvsvu0IL5nUCmIxrt6Giv/ch0zKm1ouVqtkpzkn0y
 Tw5dQgTfHmi6OaEUmQCyfRKViClM+46l/c0dbi9wL2r0YH3rokZ1Sl0NHrcm08T+Z1AD
 U2UjpVSpjKE2iZGdpD6uughfUT5CiZ7m7MpOYFnVnODjEQ7LJnSLb/ZtFDyeKOETRN99 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5a5e07np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 01:26:50 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27O1FGDf014019;
        Wed, 24 Aug 2022 01:26:50 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5a5e07mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 01:26:50 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27O1Ljde003938;
        Wed, 24 Aug 2022 01:26:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3j2q88u8ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 01:26:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27O1Njal32375096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 01:23:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 528CFA405B;
        Wed, 24 Aug 2022 01:26:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00D9BA4054;
        Wed, 24 Aug 2022 01:26:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.159.79])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Aug 2022 01:26:43 +0000 (GMT)
Message-ID: <117476d4f35be96ddba26675b849af44a5dbd6d1.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Handle -ESTALE returned by ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com
Date:   Tue, 23 Aug 2022 21:26:42 -0400
In-Reply-To: <6cd55a0f-366f-45b7-d0e5-4116de454c10@huawei.com>
References: <20220818020551.18922-1-guozihua@huawei.com>
         <b383f302284dfa31408e2796a9cae60eefd45004.camel@linux.ibm.com>
         <998ca87c-8eef-8d50-e1ee-da53ef8f0046@huawei.com>
         <c61de998f8ed1e1192297f9a2ce568a86cee3296.camel@linux.ibm.com>
         <d5861fbc-1079-a47f-e746-1072dd1d37d7@huawei.com>
         <dc34912b2bad1c46f249fb6e2aa2c79e26890699.camel@linux.ibm.com>
         <6cd55a0f-366f-45b7-d0e5-4116de454c10@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yGx5TVjYWXLDcbfg3H3MAt65zwRPldbR
X-Proofpoint-ORIG-GUID: ZmTblleQUKnKyAoS6ad--nolUxjHEXH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_10,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=970
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240001
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-08-23 at 21:28 +0800, Guozihua (Scott) wrote:
> On 2022/8/23 21:21, Mimi Zohar wrote:
> > On Tue, 2022-08-23 at 16:12 +0800, Guozihua (Scott) wrote:
> >>> The question is whether we're waiting for the SELinux policy to change
> >>> from ESTALE or whether it is the number of SELinux based IMA policy
> >>> rules or some combination of the two.  Retrying three times seems to be
> >>> random.  If SELinux waited for ESTALE to change, then it would only be
> >>> dependent on the time it took to update the SELinux based IMA policy
> >>> rules.
> >>
> >> We are waiting for ima_lsm_update_rules() to finish re-initializing all
> >> the LSM based rules.
> > 
> > Fine.  Hopefully retrying a maximum of 3 times is sufficient.
> > 
> Well, at least this should greatly reduce the chance of this issue from 
> happening.

Agreed

> This would be the best we I can think of without locking and 
> busy waiting. Maybe we can also add delays before we retry. Maybe you 
> got any other thought in mind?

Another option would be to re-introduce the equivalent of the "lazy"
LSM update on -ESTALE, but without updating the policy rule, as the
notifier callback will eventually get to it.

-- 
thanks,

Mimi

