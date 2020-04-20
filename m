Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57D1B199C
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2020 00:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDTWg3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Apr 2020 18:36:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725958AbgDTWg3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Apr 2020 18:36:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KMVNZv086931;
        Mon, 20 Apr 2020 18:36:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gcs3qm4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 18:36:13 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03KMWx4C090318;
        Mon, 20 Apr 2020 18:36:13 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gcs3qm46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 18:36:13 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03KMZJDA007844;
        Mon, 20 Apr 2020 22:36:12 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 30fs66ccpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 22:36:12 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03KMaC2O55312844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 22:36:12 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B8FBAE06A;
        Mon, 20 Apr 2020 22:36:12 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7EA6AE068;
        Mon, 20 Apr 2020 22:36:11 +0000 (GMT)
Received: from [9.85.190.235] (unknown [9.85.190.235])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 22:36:11 +0000 (GMT)
Subject: Re: [PATCH v2] tpm_tis: work around status register bug in
 STMicroelectronics TPM
To:     Omar Sandoval <osandov@osandov.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, kernel-team@fb.com
References: <c0ba1e2931ca7c46a21a43f2b9a6add2e188d6c8.1586996553.git.osandov@fb.com>
 <19d930ef-4090-3339-1088-c3579e8a080f@molgen.mpg.de>
 <20200416190249.GC701157@vader>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <addd6865-160b-c347-7607-0385ca514289@linux.ibm.com>
Date:   Mon, 20 Apr 2020 18:36:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416190249.GC701157@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_09:2020-04-20,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1011 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200173
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The model information is returned by getcapability.

TSSes like this one https://sourceforge.net/projects/ibmtpm20tss/ 
(shameless plug) have command line tools that will return the information.

E.g., this returns the TPM spec revision, TPM vendor part number, TPM 
firmware version, etc.

getcapability -cap 6 -pc 13

I assume other TSSes have similar tools.  If you want to experiment with 
TPMs, the command line tools are convenient.

On 4/16/2020 3:02 PM, Omar Sandoval wrote:
> How can I get the model information? (Sorry, I'm not very familiar with
> TPMs, I'm just the guy on the team that ended up tracking this down.)

