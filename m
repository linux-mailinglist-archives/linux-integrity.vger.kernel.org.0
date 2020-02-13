Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F7A15C9C1
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 18:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBMRx6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 12:53:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbgBMRx6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 12:53:58 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DHms5h018499;
        Thu, 13 Feb 2020 12:53:55 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1tn6hvdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 12:53:54 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01DHgear018533;
        Thu, 13 Feb 2020 17:53:53 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 2y1mm8rf3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 17:53:53 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DHrqcl48366068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 17:53:52 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3DCE6E052;
        Thu, 13 Feb 2020 17:53:51 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDE876E04C;
        Thu, 13 Feb 2020 17:53:50 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.122.180])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 17:53:50 +0000 (GMT)
Subject: Re: [PATCH 2/3] tpm: ibmvtpm: Wait for buffer to be set before
 proceeding
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, gcwilson@linux.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
 <20200204132706.3220416-3-stefanb@linux.vnet.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <568c8b9b-31e1-c6eb-c88b-12e8cf731473@linux.vnet.ibm.com>
Date:   Thu, 13 Feb 2020 12:53:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200204132706.3220416-3-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_06:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxlogscore=845 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/4/20 8:27 AM, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Synchronize with the results from the CRQs before continuing with
> the initialization. This avoids trying to send TPM commands while
> the rtce buffer has not been allocated, yet.

Seems like it is not specific to vtpm 2.0.  Shall it be clarified that 
it is a fix for vtpm 1.2 also ?

Thanks & Regards,

     - Nayna

