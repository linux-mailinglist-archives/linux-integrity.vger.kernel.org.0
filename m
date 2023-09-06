Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8142A794455
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Sep 2023 22:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244270AbjIFUNj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Sep 2023 16:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbjIFUNi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Sep 2023 16:13:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0EC19AB;
        Wed,  6 Sep 2023 13:13:34 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386KAcqE022159;
        Wed, 6 Sep 2023 20:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DFb9HATY9Bf3FAnrjHqTNOsKVgzX3rRyK/wy/jxNIOQ=;
 b=WxukGb+H1WC73OWQ3zKEBGI+gHWmpjpLbG0dDlHOppRpLi5vqimEGbJu7AYlTVqmsoU6
 5pD1C2OcRQMcmLbdM35A6bZiPX2vqqn6R2Nitz5dh7uv747/FI4WAVqUIb8rMndg7FPG
 3O+KsL0gorg2MaHpMpBt+r1tDl6coamSAEafMzytXKtdF1J5f+YsfLX2L3p8HetaC6SZ
 7MhcGMgdBRt0t0qXdr6tiaHPQ6ob/Co6ClSMLBxzu+/J+bWLzyO5EyHxm/PtaBe5oJqT
 4vHbEt5ED6yVYlvGdlUiHbjfCkfYJZ3LXJiY1kjkEbPcEYo+/jvcTw9C95ZXCPaiGVf3 TA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxyywra8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:13:10 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 386KAQnO021431;
        Wed, 6 Sep 2023 20:13:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxyywra85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:13:09 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 386INLRJ012217;
        Wed, 6 Sep 2023 20:13:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkk5wb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:13:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 386KD8CR5702308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Sep 2023 20:13:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3764358062;
        Wed,  6 Sep 2023 20:13:08 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A62C55805C;
        Wed,  6 Sep 2023 20:13:06 +0000 (GMT)
Received: from [9.67.51.26] (unknown [9.67.51.26])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  6 Sep 2023 20:13:06 +0000 (GMT)
Message-ID: <ba7d9550-03f0-9fcd-386c-382ceedbe72f@linux.ibm.com>
Date:   Wed, 6 Sep 2023 16:13:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - unseal
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
 <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
 <1d2b1df7-aabd-8a18-a564-24399b53f3d2@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <1d2b1df7-aabd-8a18-a564-24399b53f3d2@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m7najSqPMB1tCe-HWXauEWzkxJ0g8AiP
X-Proofpoint-ORIG-GUID: 9beOJqhbdXDnhuGeicESjgax82JqHbmy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=897 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309060173
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/1/2023 5:22 PM, Tushar Sugandhi wrote:
> 
> 
> On 8/30/23 12:12, Ken Goldman wrote:
>> On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
>>
>>> For remote attestation to work, the service will need to know how to
>>>  validate the snapshot_aggregate entry in the IMA log.  It will have
>>> to read the PCR values present in the template data of
>>> snapshot_aggregate event in the latest IMA log, and ensure that the
>>> PCR quotes align with the contents of the past UM_snapshot_file(s).
>>> This will re-establish the chain of trust needed for the device to
>>> pass remote attestation.  This will also maintain the ability of the
>>> remote-attestation-service to seal the secrets, if the client-server
>>>  use TPM unseal mechanism to attest the state of the device.
>>
>> I think that seal/unseal to IMA PCRs is futile.  Since boot is
>> multi-threaded, the IMA PCR is unpredictable even when valid.
> 
> True. But here we are talking about seal/unseal post boot when the
> device is in a stable state, and there are relatively less number of
> events extending IMA PCR. The value of the actual IMA PCR doesn't matter
> in this context as long as it stays the same between seal-unseal window.

Does 'relatively less number of events' really matter?  Even if there 
are only two, if the order is unpredictable, unseal fails.

> 
> If it changes between that window, the clients typically retry by
> sending the request to the service with a new stable PCR.

Does a retry help? Once the PCR has been extended to the wrong value, it 
can never get back to the correct value without a reboot.

> 
> Seal-unseal is supported by TPM spec, and is used widely. So we had to
> ensure that our proposed design wouldn't regress this existing
> functionality.

It works in the pre-OS environment, where the firmware specification 
mandates that the PCR values are repeatable. Once you're post-OS, 
multi-threaded, an unseal that includes PCR 10 is infeasible.
