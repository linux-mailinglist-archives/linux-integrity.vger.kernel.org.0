Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA37224F1
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jun 2023 13:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjFELxW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jun 2023 07:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjFELxV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jun 2023 07:53:21 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA209C;
        Mon,  5 Jun 2023 04:53:20 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355BEDpN001339;
        Mon, 5 Jun 2023 11:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=ubyyPSC97o1Z+3zgpJUVy5xq3sfEJJCSMML79921pSA=;
 b=TlidEiUYfghZaiI+Jdw49FKNuy7c56ifc/FA52xLVg0A9bdUzvLgzreJsa1oIxbQgRkT
 zhrfOGSecKqo/054+ejyZayOomolZpCMWLwbQaxm1f2DHkBxub9gowhJkvuuXpjzbfeP
 wR/E0j2R7i4ZQR8XIRCXQshMWNPB5caIKLTFB5JmnVJDXDNi4xIfJljVk2XHaa1SmJiY
 zjwGPh1IUzVlp4uHnv3nB8SpmeA2Dr4iscSzIue/7cLE3nHywOm2siKMGxLAHyY+g4qw
 5dZzKo/OI/9oHHampVGMHAZ4AG12IKoK3MPEPjkTsi2Arw6ZKMF4X8SoXV9KquS1H0G/ Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1ena8t20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 11:53:10 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355BS5C0015082;
        Mon, 5 Jun 2023 11:53:09 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1ena8t1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 11:53:09 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3557S1wY024791;
        Mon, 5 Jun 2023 11:53:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qyxep9p5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 11:53:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 355Br8oH60227970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Jun 2023 11:53:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C4AC58056;
        Mon,  5 Jun 2023 11:53:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC48E58052;
        Mon,  5 Jun 2023 11:53:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.0.86])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  5 Jun 2023 11:53:07 +0000 (GMT)
Message-ID: <85200358a6cab459dfc0fc32582d10a315af3ecd.camel@linux.ibm.com>
Subject: Re: [PATCH v2] integrity: Fix possible multiple allocation in
 integrity_inode_get()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 05 Jun 2023 07:52:59 -0400
In-Reply-To: <20230601064244.33633-1-tianjia.zhang@linux.alibaba.com>
References: <20230530121453.10249-1-tianjia.zhang@linux.alibaba.com>
         <20230601064244.33633-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QtuGVK-IvrXUMwBEZgd_dAJ4Sr8D1QxE
X-Proofpoint-GUID: fASXrHGV3sZ7gDPXP1RAn5ldeCJdWVIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=343 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-06-01 at 14:42 +0800, Tianjia Zhang wrote:
> When integrity_inode_get() is querying and inserting the cache, there
> is a conditional race in the concurrent environment.
> 
> The race condition is the result of not properly implementing
> "double-checked locking". In this case, it first checks to see if the
> iint cache record exists before taking the lock, but doesn't check
> again after taking the integrity_iint_lock.
> 
> Fixes: bf2276d10ce5 ("ima: allocating iint improvements")
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: <stable@vger.kernel.org> # v3.10+

Thanks, Tianjia.   The patch is now queued in next-integrity.

Mimi

