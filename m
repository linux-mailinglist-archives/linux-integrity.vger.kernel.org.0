Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7391997E5
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 15:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgCaNxh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 09:53:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730420AbgCaNxh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 09:53:37 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VDX0hF068094;
        Tue, 31 Mar 2020 09:52:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3044cgcm3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 09:52:25 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02VDZGeG076868;
        Tue, 31 Mar 2020 09:52:25 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3044cgcm38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 09:52:25 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02VDotVT028130;
        Tue, 31 Mar 2020 13:52:24 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 301x76s7mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 13:52:24 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02VDqMbQ54919466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 13:52:22 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2BDFB7805F;
        Tue, 31 Mar 2020 13:52:22 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41F3B7805C;
        Tue, 31 Mar 2020 13:52:16 +0000 (GMT)
Received: from [9.85.129.243] (unknown [9.85.129.243])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 13:52:15 +0000 (GMT)
Subject: Re: [PATCH v4 3/7] tpm: tpm_tis: rewrite "tpm_tis_req_canceled()"
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-4-amirmizi6@gmail.com>
 <20200331121352.GA9284@linux.intel.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <774fa2af-e4a6-4577-f1f7-c786e3b5210c@linux.ibm.com>
Date:   Tue, 31 Mar 2020 09:52:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331121352.GA9284@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_04:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/31/2020 8:13 AM, Jarkko Sakkinen wrote:
> On Tue, Mar 31, 2020 at 02:32:03PM +0300, amirmizi6@gmail.com wrote:
>> From: Amir Mizinski <amirmizi6@gmail.com>
>>
>> Using this function while read/write data resulted in aborted operation.
>> After investigating according to TCG TPM Profile (PTP) Specifications,
>> i found cancel should happen only if TPM_STS.commandReady bit is lit and
>> couldn't find a case when the current condition is valid.
>> Also only cmdReady bit need to be compared instead of the full lower status
>> register byte.
>>
>> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> 
> We don't care about spec's. We care about hardware and not all hardware
> follows specifications.
> 
> Please fix the exact thing you want to fix (and please provide a fixes
> tag).

I edit the TPM main spec, not the PTP.  As I discover TPMs that don't 
meet the spec, or where the spec has changed over time, I add 
informative comments to guide developers.

If you know of TPM hardware that does not meet the PTP specification, 
let me know the specifics.  I can bring it to the PTP work group and try 
to get comments added.

I do not need to know the TPM vendor.  That information would not go 
into the specification anyway.


