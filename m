Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2487DD63B
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Oct 2023 19:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjJaSlz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Oct 2023 14:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjJaSly (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Oct 2023 14:41:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA82A3;
        Tue, 31 Oct 2023 11:41:52 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VIeBdf007624;
        Tue, 31 Oct 2023 18:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OhxT7s0ROgOqX4hjBEGVRBCrZOsmBqayX4UGjZbJ7XQ=;
 b=VXuz51C5mgsiTlQbo/F/IXnP9QNNssQabkb7KGCswBqgjk01+QZRt1OUhJajtcdWQKEC
 1o3/HQYa1SujTZSfONi8B9zZAw3wbpJtu4Fna5IYrBlw3otITpvym7JOr3PEZcLV/PVs
 BdAfCnlhyzJyFgL/BKKLy/iuarhcvnCr3Y9jgAkwmu/wqMA8dYFWisqfKpPQC4brID8g
 BdgKV9fXti9cRb5+3EnlBuHy+1EDQC4VMa3Xc8mrOH69RnXProIrsEROt3nXInSX04ZD
 ngKlIDU1SEJtAL/+3X0a6+5AwNy1g4XZSEnI6e/giWw7GLufWh9LJREEUyrbQGlfJnTi Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u372dr2vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 18:41:31 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VIeP4J009617;
        Tue, 31 Oct 2023 18:41:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u372dr2kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 18:41:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39VGWqqY011300;
        Tue, 31 Oct 2023 18:37:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1euk29em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 18:37:37 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39VIba8i17760930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 18:37:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A13445805D;
        Tue, 31 Oct 2023 18:37:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F6F558061;
        Tue, 31 Oct 2023 18:37:20 +0000 (GMT)
Received: from [9.2.202.85] (unknown [9.2.202.85])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Oct 2023 18:37:20 +0000 (GMT)
Message-ID: <1f7bdb13-859e-46ce-b327-8043e7dbd598@linux.ibm.com>
Date:   Tue, 31 Oct 2023 14:37:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>,
        jgg@ziepe.ca, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
Content-Language: en-US
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U8ETMQ8tREdR3K8DbiFNGY17v4kgfZX2
X-Proofpoint-ORIG-GUID: kPRWCWYcnM1PEs87tSV-atqzBwEDSCsz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_05,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=993 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310150
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/19/2023 2:49 PM, Tushar Sugandhi wrote:
>    f. A new event, "snapshot_aggregate", will be computed and measured
>         in the IMA log as part of this feature.  It should help the
>         remote-attestation client/service to benefit from the IMA log
>         snapshot feature.
>         The "snapshot_aggregate" event is described in more details in
>         section "D.1 Snapshot Aggregate Event" below.

What is the use case for the snapshot aggregate?  My thinking is:

1. The platform must retain the entire measurement list.  Early 
measurements can never be discarded because a new quote verifier
must receive the entire log starting at the first measurement.

In this case, isn't the snapshot aggregate redundant?

2. There is a disadvantage to redundant data.  The verifier must support 
this new event type. It receives this event and must validate the 
aggregate against the snapshot-ed events. This is an attack surface. 
The attacker can send an aggregate and snapshot-ed measurements that do 
not match to exploit a flaw in the verifier.
