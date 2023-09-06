Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE5794469
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Sep 2023 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244350AbjIFUVS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Sep 2023 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244355AbjIFUVR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Sep 2023 16:21:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AEC19BA;
        Wed,  6 Sep 2023 13:21:10 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386K7CXD026849;
        Wed, 6 Sep 2023 20:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4S1FGnlgVG8CNcJcCSr+zNtlgy4Vmqrjs7Mg1E8ghEQ=;
 b=UBlZQHreVT7dEcoRSxgqaP+sjF9lD6P3V2b1DM+3IuBuj+yaYB0OBv/cbGfPVJYBdp9q
 OazVrt9UTT4GvjG43MUuI2npSi3iXuN73sjzNC+LxOqccLXyArx8TPVs2ddUFcZIlT+q
 NTjTYz3HS4sc56yjNWwCetv+r3gSTi1RexRYBB6d2eEt8nYN6N4zHzz/7LoxJkpREKgi
 IQ9UO1/Oxunkp/Li8qEPC9fi0XgvIyBzQqt4yDFQEG05rFakjAfl2/jTdf1KOHKhsAN5
 ZhbBoqRnE7kk0+mdTV69YgxQOhIET+Qcp4GP271MRv4qxTFw6mkKKmYdB+3wU056MH0x Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sy01fgpr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:20:41 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 386K7HCh027204;
        Wed, 6 Sep 2023 20:20:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sy01fgpqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:20:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 386IeKaJ001603;
        Wed, 6 Sep 2023 20:20:39 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfcsxp5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:20:39 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 386KKdDv6619866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Sep 2023 20:20:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1793658054;
        Wed,  6 Sep 2023 20:20:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D4E958064;
        Wed,  6 Sep 2023 20:20:37 +0000 (GMT)
Received: from [9.67.51.26] (unknown [9.67.51.26])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  6 Sep 2023 20:20:37 +0000 (GMT)
Message-ID: <696e8be1-ad31-4ffd-711d-6fb5ce54fbd4@linux.ibm.com>
Date:   Wed, 6 Sep 2023 16:20:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - network bandwidth
Content-Language: en-US
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <5c323243-e22e-dd61-f808-2875654936a6@linux.ibm.com>
 <5ce32966-c8c5-adc4-8b9e-f8300b266a61@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <5ce32966-c8c5-adc4-8b9e-f8300b266a61@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w4aTGIqhqc_QBDXnvfHvicBBpwDQ4BWa
X-Proofpoint-ORIG-GUID: -1ErvS4Zf79QrjeqkwiCVT28d9Hi2kmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0 mlxlogscore=942
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060173
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/1/2023 5:20 PM, Tushar Sugandhi wrote:
> Thanks a lot Ken for looking at the proposal, and sharing your thoughts.
> 
> On 8/30/23 11:06, Ken Goldman wrote:
>>
>>
>> On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
>>> In addition, a large IMA log can add pressure on the network 
>>> bandwidth when
>>> the attestation client sends it to remote-attestation-service.
>>
>> I would not worry too much about network bandwidth.
> Our bandwidth concerns are about scaled out system.
> 
> When IMA log size increases in the range of megabytes, and when the
> number of client devices increases, it makes an impact on the overall
> network bandwidth.

It should not, because the client only sends new measurements.  It only 
sends the entire list once per boot.

Does a megabyte matter in a modern network? As for overall performance,
a megabyte may take 10 msec, while the TPM quote could take 1000 msec, 
and verifier hash and asymmetric signature checks are also slower.

> 
>>
>> 1. Every solution eventually realizes that sending the entire log each 
>> time hurts performance.  The verifier will ask the attestor, "give me 
>> everything since record n", and the number of new entries approaches 
>> zero.
>>
> Completely agreed. IMA log snapshotting (this proposed feature) is a
> solution in that direction.

Does snapshotting matter?  The first time, the attester sends the entire 
log, whether part is snapshotted or not.  Same with incremental attestation.

I don't understand how snapshotting would have any affect on network 
traffic.

