Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0723C36CB81
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Apr 2021 21:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhD0TNu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 15:13:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230219AbhD0TNt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 15:13:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RJ3xQW099082;
        Tue, 27 Apr 2021 15:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : from : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tLfscSpWyfyGcsG2HrC1jfsbhxnc4PrmbXlEpD8YKLQ=;
 b=smlfHmD4O3pjnNUFd5m9oVK5gbObeO8IcmgomGkLTQiVT5Rgn+faFzZBwUStpUZyrTD8
 qO0yQ90NleIjbCFm0mBNEHmc5Bvd1St8GNvO6J2BJVUzP99IbPaA1wgJF0XQHTd8UdbQ
 zbh/hFW2QDYAGIs0ZPnX4dOQDAExtEz0shRMG6icDQQaYcH1VUixJgpn6IgQ8yAALOzw
 YgwcWLEY0KqZUJz3V9F7flqW/kKRYo++gbda3RnwcIVlYgpQfJfNzXEBXCpOiwpUZevx
 /tEH/vY6MHX6KFznO2sdstDczbvtmjEkDvrDxIQWbj+h5VXQ8okgYVXnGi+x/dtBJpwB pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 386muqy0yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 15:13:03 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13RJ50P1102838;
        Tue, 27 Apr 2021 15:13:03 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 386muqy0yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 15:13:03 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RJ7Kdu028183;
        Tue, 27 Apr 2021 19:13:02 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 384ay9fjak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 19:13:02 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RJD1io31457692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 19:13:01 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4514C112062;
        Tue, 27 Apr 2021 19:13:01 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35B22112066;
        Tue, 27 Apr 2021 19:13:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Apr 2021 19:13:01 +0000 (GMT)
Subject: Re: [PATCH 1/3] libimaevm: Implement imaevm_create_ima_signature
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     Colin Walters <walters@verbum.org>, linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
References: <20210420183015.861644-1-stefanb@linux.ibm.com>
 <20210420183015.861644-2-stefanb@linux.ibm.com>
 <4a4d068b-569c-4ffd-ba32-8656f761a3b5@www.fastmail.com>
 <1add81aa-85e6-68b1-4a48-b19ad33683c6@linux.ibm.com>
Message-ID: <24c40feb-4e98-8641-6af2-11d5c666ef75@linux.ibm.com>
Date:   Tue, 27 Apr 2021 15:13:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1add81aa-85e6-68b1-4a48-b19ad33683c6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NBPqh5Pl9xLJaEezsORU1TyHLysjJ3OI
X-Proofpoint-ORIG-GUID: U03I7fY5tMwpWhg1hcn0I9__Ll9IrgYu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_11:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/27/21 1:47 PM, Stefan Berger wrote:
>
> On 4/26/21 8:02 PM, Colin Walters wrote:
>>
>> On Tue, Apr 20, 2021, at 2:30 PM, Stefan Berger wrote:
>>
>>> + fd = open(filename, O_RDONLY);
>> Missing O_CLOEXEC.
>
>
> Will do.
>
>>
>>> +int imaevm_create_ima_signature(const char *filename, EVP_PKEY *pkey,
>> It'd maximize flexibility for the caller to pass a file descriptor, 
>> and not a file name.
>
>
> We could do this with a callback where the user implements the 
> callback function and providers buffer, size of buffer, and eof 
> indicator, and gets called for providing the data to hash. That would 
> maybe be even more flexible..


Actually, I cannot do this. For this function we have to call 
ima_calc_hash, which hashes, files, links, directories etc.


     Stefan


