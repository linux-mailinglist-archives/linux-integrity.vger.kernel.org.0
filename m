Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F678E139
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 23:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbjH3VLv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 17:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbjH3VLu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 17:11:50 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09270E57;
        Wed, 30 Aug 2023 14:11:15 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UJ7RJQ025365;
        Wed, 30 Aug 2023 19:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nsWoYyWcb5D+Vc8qBgf5Yn3B+5VG4LYGM1UuJXlgJrE=;
 b=MzGxKElHrjv36Kuqq8oENZk+2iWe/ZDZiJ/h6CDdCzqEawzE1slJjKiyFLIVLn6fvb4w
 y7UbM5s835OnQR9HSBv9Tpt3rLdU4lYGbFdbIpfl5FBAIY3CtDEDyZWWl9KchPUj/X9r
 /UfCSGVn9O4yXd+KCimXmGpWty2OOqY54rqofARiU/BqtMOF9OMaExvIjKEMWTzX3LDr
 5BE3U/z93gqTOTDgMTu4QZShLilayW2NMrhOM6RxWWzl9yJqA+B1wx+uDaJfg0J8VZRz
 HCyPshNUcafAlfBT9xlzZx/oxE7XxgYVc9AKdZ9WrpXsY4JSUQzC07y1y+RcjxM/gxN4 Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stakf9maj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 19:12:43 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37UJ8SWQ032384;
        Wed, 30 Aug 2023 19:12:42 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stakf9mab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 19:12:42 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UH8WTd019171;
        Wed, 30 Aug 2023 19:12:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe1wsyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 19:12:41 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UJCecF5571312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 19:12:41 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9C7F58054;
        Wed, 30 Aug 2023 19:12:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C40758045;
        Wed, 30 Aug 2023 19:12:39 +0000 (GMT)
Received: from [9.67.11.225] (unknown [9.67.11.225])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Aug 2023 19:12:39 +0000 (GMT)
Message-ID: <1ef45099-da24-b73f-b33f-6a299c0b1696@linux.ibm.com>
Date:   Wed, 30 Aug 2023 15:12:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - unseal
Content-Language: en-US
To:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1AJMc18zBnZZ7vPrb1MSLrtmROyoaSmV
X-Proofpoint-GUID: vSpjfjen1JRsAVCDdiH0La52j66-fZAA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 mlxlogscore=670 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308300172
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/1/2023 3:12 PM, Sush Shringarputale wrote:

> For remote attestation to work, the service will need to know how to
>  validate the snapshot_aggregate entry in the IMA log.  It will have
> to read the PCR values present in the template data of
> snapshot_aggregate event in the latest IMA log, and ensure that the
> PCR quotes align with the contents of the past UM_snapshot_file(s).
> This will re-establish the chain of trust needed for the device to
> pass remote attestation.  This will also maintain the ability of the
> remote-attestation-service to seal the secrets, if the client-server
>  use TPM unseal mechanism to attest the state of the device.

I think that seal/unseal to IMA PCRs is futile.  Since boot is
multi-threaded, the IMA PCR is unpredictable even when valid.

