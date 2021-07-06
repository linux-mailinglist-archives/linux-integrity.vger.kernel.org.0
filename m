Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969D43BDDA9
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jul 2021 20:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhGFSyw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 14:54:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42958 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231556AbhGFSyw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 14:54:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 166InI1Z177281
        for <linux-integrity@vger.kernel.org>; Tue, 6 Jul 2021 14:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=L2F2x7+ywK240E2E32V8jrsQ933KG/cKDt2IIDmru4c=;
 b=SXs+6WSyjvnQf0NrICj/NTPPcPXLJh93Pwrhyg9DGE6HWglugwfLBMwgZkyJoaNwZGsM
 xbMV88oQ9epD9PqCnY2CNbHjIxtZCEIAhvS3Os9ozc2YgJVCFJ07TtdVekVrJ81GAoFg
 Q2MYESfOE3oTeIa7oRM/KI/AqPB5LjhfxO3wIgQJFDzMPiEUX90GP3sJMEOOVhR1xLLV
 M9Zke2++RoXDKoghy4GvPgIvw0I+LGq8c9NpShVmgXIswYevifcckgrMiak0XdgI4Ww2
 I2Fc5XAq2ScXICjtzGgfybeh5MenSXGaVx58FEIo/Ek5rcQcQZSZweFlQBuxpH/3gN0Y 1g== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39me2bfee2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 06 Jul 2021 14:52:12 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 166ITC5q019145
        for <linux-integrity@vger.kernel.org>; Tue, 6 Jul 2021 18:52:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 39jfh8sd34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 06 Jul 2021 18:52:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 166IoFbF25821586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Jul 2021 18:50:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1379A404D;
        Tue,  6 Jul 2021 18:52:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21225A405B;
        Tue,  6 Jul 2021 18:52:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.34.2])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Jul 2021 18:52:06 +0000 (GMT)
Message-ID: <de2a25ccff2d33015df0efebddf6df98fd5ceeb5.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils 0/3] libimaevm: Remove digest calculations
 not supported by IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 06 Jul 2021 14:52:05 -0400
In-Reply-To: <20210630193303.2531284-1-stefanb@linux.ibm.com>
References: <20210630193303.2531284-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BmJOBK58XP0UGdiQS0c8NuCPShzjKO6q
X-Proofpoint-GUID: BmJOBK58XP0UGdiQS0c8NuCPShzjKO6q
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_10:2021-07-06,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

On Wed, 2021-06-30 at 15:33 -0400, Stefan Berger wrote:
> Remove digest calculations over directories, symbolic links, and device files
> since those and related signature verifications are not supported by IMA in
> the kernel.
> 
> Regards,
>    Stefan

Thanks, Stefan.  Other than removing the related features from the
README, it looks good.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


> Stefan Berger (3):
>   libimaevm: Remove calculation of a digest over a device file
>   libimaevm: Remove calculation of a digest over a directory
>   libimaevm: Remove calculation of a digest over a symbolic link
> 
>  src/libimaevm.c | 68 -------------------------------------------------
>  1 file changed, 68 deletions(-)
> 


