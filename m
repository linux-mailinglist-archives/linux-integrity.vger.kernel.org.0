Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D05D6BA29A
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 23:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCNWil (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 18:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjCNWik (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 18:38:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F099E22C86
        for <linux-integrity@vger.kernel.org>; Tue, 14 Mar 2023 15:38:37 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EMU2wF016177;
        Tue, 14 Mar 2023 22:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=sIr3cjOHRg8t1BSxBpSyEV5EWrYm0AghP60gHoc3gsA=;
 b=WHtWk+2WzT4qAhuxMVSZzpiMdJfSYKsGetZY5lf2A/G3+fWPpEalAsk/gVlHNhfsJyOk
 l/Ul3T0pOp/H/XGD3nr8PcMfInVpahVO8Tc3FNrZyB8jgXEAKjVTElbXtiOjL0aZUxtk
 HmxDsPv1SjNfTQHZguyt9IAXnz708kMnNjDUOrdarnEtnVQYYj/GU3C5PKhdn7YUQAkZ
 rK2Wg+LxKxogA3aQz1IqjaWFH9klGZgUln4CjrWJ75cWesmPo5OkgNcb5Rb5ftKur97k
 yDG2w8ZNLniQrnb3l310tb4JlNf+31+yJ6bE8k1M0RYzeTVz2ru3Y78lq+DQ+XHEyFF6 IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pb1rxg4f6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 22:38:35 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EMcYpS013085;
        Tue, 14 Mar 2023 22:38:34 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pb1rxg4f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 22:38:34 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32EL4fHT018118;
        Tue, 14 Mar 2023 22:38:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3p8h97e7j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 22:38:33 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32EMcXPX6226446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 22:38:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE8D75805D;
        Tue, 14 Mar 2023 22:38:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BF7458054;
        Tue, 14 Mar 2023 22:38:32 +0000 (GMT)
Received: from sig-9-65-194-57.ibm.com (unknown [9.65.194.57])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 22:38:31 +0000 (GMT)
Message-ID: <cad8053945499c1e9b9483a55f5929e3232a64fa.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Fix fsverity.test mount failure for ppc64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Tue, 14 Mar 2023 18:38:31 -0400
In-Reply-To: <20230311091644.647214-1-vt@altlinux.org>
References: <20230311091644.647214-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Cvrlge1TBzjUlRghMB_bJ1SgO_aAurJX
X-Proofpoint-GUID: ByJBKSOcEG2tqeC-6iWjevTvOFK9wD8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_14,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=966 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140180
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2023-03-11 at 12:16 +0300, Vitaly Chikunov wrote:
> fsverity requires fs blocksize to be equal to pagesoze, which is
> different on ppc64 (64K). Default mkfs blocksize if 4K. This difference
> causes mount failure and following error message:
> 
>   INFO: Mounting loopback filesystem
>   mount: /tmp/fsverity-test: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
>          dmesg(1) may have more information after failed mount system call.
>   FAILURE: mounting loopback filesystem
> 
> It's said this limitation is removed in Linux v6.3, but for backward
> compatibility better to leave workaround for it.
> 
> Fixes: b259a2b ("tests: add fsverity measurement test")
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Thanks, Vitaly.  The patch is now queued in next-testing.

-- 
Mimi

