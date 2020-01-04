Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B5130507
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Jan 2020 00:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgADXPP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Jan 2020 18:15:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbgADXPO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Jan 2020 18:15:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 004NCL8W100243
        for <linux-integrity@vger.kernel.org>; Sat, 4 Jan 2020 18:15:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xar46etv7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 04 Jan 2020 18:15:13 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sat, 4 Jan 2020 23:15:11 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 4 Jan 2020 23:15:08 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 004NF7xO46792724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Jan 2020 23:15:07 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54D66A4060;
        Sat,  4 Jan 2020 23:15:07 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92203A4054;
        Sat,  4 Jan 2020 23:15:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.186.80])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  4 Jan 2020 23:15:06 +0000 (GMT)
Subject: Re: ERROR: "process_buffer_measurement"
 [security/integrity/ima/ima_asymmetric_keys.ko] undefined!
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Date:   Sat, 04 Jan 2020 18:15:06 -0500
In-Reply-To: <ae08cbb4-82f4-c6d7-b5cf-860874319a46@linux.microsoft.com>
References: <202001050229.ig7cUcrs%lkp@intel.com>
         <ae08cbb4-82f4-c6d7-b5cf-860874319a46@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20010423-0016-0000-0000-000002DA7FE7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010423-0017-0000-0000-0000333CEFDB
Message-Id: <1578179706.5152.18.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-04_06:2020-01-02,2020-01-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=888 impostorscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001040221
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-01-04 at 10:53 -0800, Lakshmi Ramasubramanian wrote:
> On 1/4/2020 10:37 AM, kbuild test robot wrote:
> 
> >     WARNING: modpost: missing MODULE_LICENSE() in security/integrity/ima/ima_asymmetric_keys.o
> >     see include/linux/module.h for more information
> 
> The new file ima_asymmetric_keys.c does have the license header (similar 
> to the license header in other files in IMA folder). Did I missing 
> something?
> 
> >>> ERROR: "process_buffer_measurement" [security/integrity/ima/ima_asymmetric_keys.ko] undefined!
> 
> process_buffer_measurement() is defined ima_main.c - this function was 
> updated in Nayna's patch and I had updated it.

It's trying to build ima_asymmetric_keys.c for some reason as a
separate kernel module, which it isn't.

Mimi

