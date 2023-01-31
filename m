Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7E5683178
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 16:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjAaP1L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 10:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjAaP1F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 10:27:05 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2235F2;
        Tue, 31 Jan 2023 07:27:04 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VEcYOe031568;
        Tue, 31 Jan 2023 15:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gcnjKFBnH8wN08/T7zPKmCfx9PRehWOSVHo37flKe/o=;
 b=nwpn9UBveOUrA1xTGfErweS6lM+M8M9tiYUmLD18OKkABS3T2MvqvC19Jaudie+iKsaD
 3mA7EOZsw26GT2Vtcz2p2+2Z2lplNw9GlWAO/tigfweEXltQGhzqZqPJl505Ecto5OfX
 O/oQ6xB0G58GsHc6zKRGDHKa64zIKCflnTfUugT6zqh7C2rqF3gjfrYxnnJQk3mWW8ec
 ZEnZaPsvrFPydIKTbAQpWo8rOc8BjOO3WQ7o1ozS8I7dXufbgx2hauNsB899z2MO7ZPi
 mhLHQhLcdyp20rUtc8Bc+3HJsF1tmhNgdQS2YGT5QTPSIm5ZF7oU9WKLasDK6g9Ni0tP 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf18kfh91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:26:55 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VEtPVi036821;
        Tue, 31 Jan 2023 15:26:55 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf18kfh8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:26:55 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VDRmKv006449;
        Tue, 31 Jan 2023 15:26:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ncvtmcry1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:26:54 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VFQqut61735202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:26:52 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7525D5805D;
        Tue, 31 Jan 2023 15:26:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 076BF5805C;
        Tue, 31 Jan 2023 15:26:51 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 15:26:50 +0000 (GMT)
Message-ID: <50df1b71-5a8d-2353-6c30-07904c373591@linux.ibm.com>
Date:   Tue, 31 Jan 2023 10:26:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 08/25] powerpc/secvar: Handle max object size in the
 consumer
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230131063928.388035-1-ajd@linux.ibm.com>
 <20230131063928.388035-9-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230131063928.388035-9-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jsd_b6o0qY70NrzJA4f1u0otJsPt3ynw
X-Proofpoint-ORIG-GUID: 8iHzpDelQsEsxYncaWe-NI75R8Jx_1A9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310135
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/31/23 01:39, Andrew Donnellan wrote:
> From: Russell Currey <ruscur@russell.cc>
> 
> Currently the max object size is handled in the core secvar code with an
> entirely OPAL-specific implementation, so create a new max_size() op and
> move the existing implementation into the powernv platform.  Should be
> no functional change.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
