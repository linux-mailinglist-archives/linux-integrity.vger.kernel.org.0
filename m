Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E485617C1E
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 13:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKCMFI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 08:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiKCMFH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 08:05:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4871261B
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 05:05:07 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3Bb4xd024067;
        Thu, 3 Nov 2022 12:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ce4camKnWEtEnhmJBheAPp6aI2Kc3dfsqhJM6hBPrjY=;
 b=qRuzJN0+lz+BWm4H47uZ3O72AnSaOnsI5mSNk0nuAw3vrwb9mrPwoyCN09qSIsNUx/v3
 SxUOPKVXly0qjWTb8ixuissix/qXju5xbv+7E3BBNjMbUz0xtk/w0RlAzctnjaOgmzGg
 Vbay/JF8SDqM7zNxIKWubNZpIttmdIKY88FgyiZ+2U3k3L8Z3v3RNxs7+NYHRc63IshM
 XDCitnEKiGIBt0IeVm7bq8AtvMF6Rarf8m9EZxnb4SuT+c4nLP5QJIPqklNzo7AXDKAq
 RBDlVVHNWYDsBTehcwcWiVjQ4O78OzVhhUNX3bbaUZl5Q/sBkHR2BrEpOA9JR34hrIG4 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmbdbujp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 12:04:55 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A3BbBPb025164;
        Thu, 3 Nov 2022 12:04:55 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmbdbujn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 12:04:55 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3BoBtn019433;
        Thu, 3 Nov 2022 12:04:53 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 3kguta940v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 12:04:53 +0000
Received: from smtpav02.wdc07v.mail.ibm.com ([9.208.128.114])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3C4qu266257172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 12:04:52 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D9C158068;
        Thu,  3 Nov 2022 12:04:52 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F9A35805D;
        Thu,  3 Nov 2022 12:04:51 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.20.100])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 12:04:51 +0000 (GMT)
Message-ID: <7a151334df92108441d32da315022be068c2f89d.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: Fix a potential NULL pointer access in
 ima_restore_measurement_list
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Huaxin Lu <luhuaxin1@huawei.com>, linux-integrity@vger.kernel.org
Cc:     dmitry.kasatkin@gmail.com
Date:   Thu, 03 Nov 2022 08:04:51 -0400
In-Reply-To: <20221102160949.28779-1-luhuaxin1@huawei.com>
References: <20221102160949.28779-1-luhuaxin1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NQAxWGhs9HdMFDTgIimERW_FjuCECjJR
X-Proofpoint-GUID: qIbxldt5Apy1HvpQP2d7r20tNk5V0n5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_02,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030083
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-11-03 at 00:09 +0800, Huaxin Lu wrote:
> In restore_template_fmt, when kstrdup fails, a non-NULL value will still be
> returned, which causes a NULL pointer access in template_desc_init_fields.
> 
> Co-developed-by: Jiaming Li <lijiaming30@huawei.com>
> Signed-off-by: Jiaming Li <lijiaming30@huawei.com>
> Signed-off-by: Huaxin Lu <luhuaxin1@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

Thank you.   This patch is now queued in next-integrity.

-- 
Mimi

