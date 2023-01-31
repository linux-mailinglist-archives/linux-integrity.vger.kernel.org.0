Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBE36833A1
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 18:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjAaRTN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 12:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjAaRSd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 12:18:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761794AA71;
        Tue, 31 Jan 2023 09:18:07 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VG06Ca009039;
        Tue, 31 Jan 2023 17:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=g5Nz1N51a9LvLF+LPsrVOUApZAL6oSBYkLnDjZdTvb8=;
 b=hCUk9/+P86Yxz5nF1p4oJ2ScUOPRflOFeyHGJfQoWcRsue3KPnIw0WITfXRJCFQZL6Ww
 g5OnSq0rJI21AApFaVSuPHieHa/9Y4EQLiOT7g5OibvHUsL6NWybXCmeocqidvjEJ0Va
 whv6TctVGU5q0smcYezl+6Q1Q/wgol9jww1UHmGd4lXFMNSKK5JMKYMYAEVYB4OVF7DJ
 lUN5+wdVVphY5VD24i8pCAx747mZG7Zf3PBgjwsg8I+m0ZHyGyoIV9MPUJNiyUdLVAOu
 umNfHxUzqn3GnSbgVCU3GW/e/qIigCFeWz2K5dxAM9Y0ye7NRSdJBLP9i22NswmHxGiK UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf31nfrqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 17:17:17 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VGT5Rj018708;
        Tue, 31 Jan 2023 17:17:16 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf31nfrqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 17:17:16 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGAiA1019225;
        Tue, 31 Jan 2023 17:17:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3ncvuqnbvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 17:17:15 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VHHDrA28573986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 17:17:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3440058065;
        Tue, 31 Jan 2023 17:17:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48CF558056;
        Tue, 31 Jan 2023 17:17:12 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 17:17:12 +0000 (GMT)
Message-ID: <5fc51ed4-19fa-6116-0f8a-a67b7d746398@linux.ibm.com>
Date:   Tue, 31 Jan 2023 12:17:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 25/25] integrity/powerpc: Support loading keys from
 PLPKS
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230131063928.388035-1-ajd@linux.ibm.com>
 <20230131063928.388035-26-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230131063928.388035-26-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DwSd9rXQKvF4RVlIxzqSXJPfTeCSGuns
X-Proofpoint-GUID: YEp6XU2nuMKdsH4FqzATq8ZJwPLiJWQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301310150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/31/23 01:39, Andrew Donnellan wrote:
> From: Russell Currey <ruscur@russell.cc>
> 
> Add support for loading keys from the PLPKS on pseries machines, with the
> "ibm,plpks-sb-v1" format.
> 
> The object format is expected to be the same, so there shouldn't be any
> functional differences between objects retrieved on powernv or pseries.
> 
> Unlike on powernv, on pseries the format string isn't contained in the
> device tree. Use secvar_ops->format() to fetch the format string in a
> generic manner, rather than searching the device tree ourselves.
> 
> (The current code searches the device tree for a node compatible with
> "ibm,edk2-compat-v1". This patch switches to calling secvar_ops->format(),
> which in the case of OPAL/powernv means opal_secvar_format(), which
> searches the device tree for a node compatible with "ibm,secvar-backend"
> and checks its "format" property. These are equivalent, as skiboot creates
> a node with both "ibm,edk2-compat-v1" and "ibm,secvar-backend" as
> compatible strings.)
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
