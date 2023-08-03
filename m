Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C716C76F5DE
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 00:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjHCW4O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 18:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjHCW4O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 18:56:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AEFAC
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 15:56:12 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373MsIfV011391;
        Thu, 3 Aug 2023 22:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hppF3aZYJ8kwrLf6dHRucYmqqNY7MbJGS8+ol2sGIas=;
 b=gW3vmjDxzCDldsDox+60nXyWSxaT0CUTKRJYSXLlY2VD4y9StoXEP2vfIBHzPpHE/266
 zCW0U9LMZ54RGSfGHpJRD2bLn8TI6jDPXVNxg/K7bhhRrVotfq8H8DyNTZ2lMNIsI/CL
 YAbQARrMVqZ7dGbvcRnQP7fCqM1JW+zp01AqlnXb1L6anv6ifOYA7gZ1V8HeYtoga4aG
 d2LDNT2qIWwqq+3xbslPRIR+PWgnyeInNWQma4nsJBLk9OlrATEQlDOqpHkTHhCxAoaP
 6SW/WBapLedz2SCC25mz5Op39RME8uOzHO23rviB/xls3REw82ADEcY83iabToq1Hs6N sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mxb0f4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:55:47 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373MhZjb010557;
        Thu, 3 Aug 2023 22:55:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mxb0f4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:55:45 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373Knmci023537;
        Thu, 3 Aug 2023 22:55:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8km9gq35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:55:45 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373Mtivi65208768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 22:55:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8527958061;
        Thu,  3 Aug 2023 22:55:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBE8D58056;
        Thu,  3 Aug 2023 22:55:43 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Aug 2023 22:55:43 +0000 (GMT)
Message-ID: <dc883eeb-729d-f951-ba1b-9c030eed8b93@linux.ibm.com>
Date:   Thu, 3 Aug 2023 18:55:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/6] Measuring TPM update counter in IMA
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
 <dbfb545b-9399-d505-6739-c2940930ef48@linux.ibm.com>
 <cb2029b8-d585-1c06-a0ac-15624cf70e28@linux.microsoft.com>
 <a4a5e40b-abc1-27fa-3984-cee18fb4522c@linux.ibm.com>
 <d51cd6959472885a59fc13b863b71f2157fc8f65.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <d51cd6959472885a59fc13b863b71f2157fc8f65.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7rT4Gu6yYuot68cF3j025JAW6n5j5wh1
X-Proofpoint-ORIG-GUID: yT5c7vkIbkd1-22MM3H7crqoKtzB5foM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030203
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/3/23 18:36, Mimi Zohar wrote:
> On Thu, 2023-08-03 at 18:09 -0400, Stefan Berger wrote:
>>> I can remove the kexec example if it is causing confusion.> Please let me know.
>>
>> I am not convinced we need this series  ... :-( Your kexec series prevents
>> further logging and especially PCR extensions after the frozen measurement log
>> has been created and in ima_add_template_entry(), if we hit an oom condition,
>> then we luckily do not extend the PCR either. If either the log was to have one
>> more entry than number PCR extensions occurred or vice versa, then the remote
>> attestation service will see this mismatch no matter what and all the PCR update
>> counter won't help (and is generally not a good indicator for this purpose imo)
>> for it to recover from this. It's better to declare the system as un-trusted/
>> corrupted in this case then.
> 
> As previously mentioned, there is a patch set that doesn't carry any
> records across kexec, if the the measurement list is too large, and
> another proposal to trim the measurement list.
> 
> In both of these cases including a new IMA mesaurement record, at least
> after the boot_aggregate, would help simplify detecting whether the
> measurement list has been trimmed/truncated.
> 

And if you can detect that I would log an event but not using the PCR update counter.
Unless the state of PCRs is also logged, it's going to be unrecoverable for a log+quote
verifier from there.

    Stefan
