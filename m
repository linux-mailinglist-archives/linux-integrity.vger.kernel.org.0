Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A841477436C
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Aug 2023 20:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbjHHSD3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Aug 2023 14:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjHHSDV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Aug 2023 14:03:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC118C3E;
        Tue,  8 Aug 2023 09:54:17 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DQcUS031294;
        Tue, 8 Aug 2023 13:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=imIIl8L+vkBWnV0h4KE1fia6y0JHptbEv6N+lC/1pN0=;
 b=lmt20ZzrTmqUa7M2EI8M0JYAYkRLZYzbTIxhk37jmqr89R3eLFudeDF3Mg9G8yAjA8+v
 QxSrmFZ+T/mMHgwmwcML5nu/FALJbDQYNkUGo7+KuuMaLSD+Kan1kUXrwGb4XAZG8Fi1
 njN9zmHvOReQPWem5xgck05yoweNuSSqjbw5278gBt21edsWFBHddHOGgRXcx9cEYJOR
 3krrSYxL9pAFH/rKUYPbJJVyZ+USeQiX2OahjAzTVtExCSOPte/Yu67S/396/8Dkp93B
 Fr9Raevi3RD3AZSwgLzE0sqdmB4pgv6BkS64DsJV/iBxs6AWZk8hjyi30Yp8SHnOE2q4 Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbpkg84dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 13:31:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 378DRlgo001269;
        Tue, 8 Aug 2023 13:31:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbpkg84cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 13:31:07 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 378CePDw007606;
        Tue, 8 Aug 2023 13:31:05 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14y76ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 13:31:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 378DV4PQ54985068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Aug 2023 13:31:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42D6F58054;
        Tue,  8 Aug 2023 13:31:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8337F5805A;
        Tue,  8 Aug 2023 13:31:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  8 Aug 2023 13:31:01 +0000 (GMT)
Message-ID: <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
Date:   Tue, 8 Aug 2023 09:31:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
 <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Bw5pNJKVqwaygz4Erruc0C1ZClMW8o70
X-Proofpoint-ORIG-GUID: G1w8O5iQqwDpEFgs4HQ6jr7_Qu6FlenJ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_10,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=996 spamscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080116
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/8/23 08:35, James Bottomley wrote:
> On Mon, 2023-08-07 at 18:49 -0400, Stefan Berger wrote:
>>
>>
>> On 8/1/23 17:21, James Bottomley wrote:
>>> On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
>>> [...]
>>>> Truncating IMA log to reclaim memory is not feasible, since it
>>>> makes the log go out of sync with the TPM PCR quote making remote
>>>> attestation fail.
>>>
>>> This assumption isn't entirely true.  It's perfectly possible to
>>> shard an IMA log using two TPM2_Quote's for the beginning and end
>>> PCR values to validate the shard.  The IMA log could be truncated
>>> in the same way (replace the removed part of the log with a
>>> TPM2_Quote and AK, so the log still validates from the beginning
>>> quote to the end).
>>>
>>> If you use a TPM2_Quote mechanism to save the log, all you need to
>>> do is have the kernel generate the quote with an internal AK.  You
>>> can keep a record of the quote and the AK at the beginning of the
>>> truncated kernel log.  If the truncated entries are saved in a file
>>> shard it
>>
>> The truncation seems dangerous to me. Maybe not all the scenarios
>> with an attestation client (client = reading logs and quoting) are
>> possible then anymore, such as starting an attestation client only
>> after truncation but a verifier must have witnessed the system's PCRs
>> and log state before the truncation occurred.
> 
> That's not exactly correct.  Nothing needs to have "witnessed" the
> starting PCR value because the quote vouches for it (and can vouch for
> it after the fact).  The only thing you need to verify the quote is the
> attestation key and the only thing you need to do to trust the> attestation key is ensure it was TPM created.  All of that can be
> verified after the fact as well.  The only thing that can be done to
> disrupt this is to destroy the TPM (or re-own it).> 
> Remember the assumption is you *also* have the removed log shard to
> present.  From that the PCR state of the starting quote can be

Yes, the whole sequence of old logs needs to be available. IF that's the
case and the logs can be stitched together seamlessly, who then looks at the
kernel AK quote and under what circumstances?

> calculated and checked for matching the quote.  If you lose that, it's
> equivalent to the log being tampered with and all bets are off.  The
> assumption is that because of the impossibility of engineering TPM
> extensions, it should be impossible to come up with a fake log that
> produces the PCRs of the real one.  If that's violated, then IMA itself
> becomes useless.
> 
> James
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
