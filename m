Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF03D593004
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Aug 2022 15:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiHONem (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Aug 2022 09:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHONel (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Aug 2022 09:34:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B114920F58;
        Mon, 15 Aug 2022 06:34:40 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FDEIQ1027150;
        Mon, 15 Aug 2022 13:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=uZ/gxg4vwNI6HXYTM5WtTwqBD5xiz145jUdLuTNzlO8=;
 b=K+vfDuUO+MnNMVtKMlY95pl7vMYTvxjNayVwBZPhe91x8k0IjdiCAxhUEmY4eyymlahh
 xUx/DwupRRNVtajezziJOYoHrmOL69zoivO8lPv2crRN4is4pFOphY/wRRiPiOwzMwqi
 6rWDwM/B1BaFWUgBTggMmY88b6EhW3tDO89JB0pF03An5VOmXtbd6EgWDsCFbPzFQM6Q
 uZvGzoqtSAIk+sQZkzQz290aHr2cCMFGKfCUdQiw1i4M46leqJKQs36E3RicJtSRgvIw
 DlaQNyowDfmowsIkE2nBg/HlYfdFukxsVyLa2IyngNjOp0ecwHknE8Hflk/pe6BDkU7R jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyny39s47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 13:32:22 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27FDTcdW019263;
        Mon, 15 Aug 2022 13:32:21 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hyny39s3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 13:32:21 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27FDM3Qr006945;
        Mon, 15 Aug 2022 13:32:20 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 3hx3ka76kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 13:32:20 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27FDWJVB35913988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Aug 2022 13:32:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A55ECB2068;
        Mon, 15 Aug 2022 13:32:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EE68B2064;
        Mon, 15 Aug 2022 13:32:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 15 Aug 2022 13:32:19 +0000 (GMT)
Message-ID: <94d1ba97-3fcf-bb75-ce3e-d6a8ca712ece@linux.ibm.com>
Date:   Mon, 15 Aug 2022 09:32:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 0/6] tpm: Preserve TPM measurement log across kexec
 (ppc64)
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
 <20220815064813.77g6icbkygrbmapa@Rk>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220815064813.77g6icbkygrbmapa@Rk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ptO3BKkSCoh7-5bQX2n7qnM51LmKpyR
X-Proofpoint-ORIG-GUID: SjJwR0iv4r6SJJUKhXKap-xyAeb2ZD_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/15/22 02:48, Coiby Xu wrote:
> I can confirm this patch set fixes an issue that guest kdump kernel
> crashes on POWER9 host by applying it to 5.19.1 (there is a conflict
> when applying this patch set to latest kernel i.e. 6.0.0-rc1)

I rebased it. 2 of the borrowed patches disappeared now since they are 
upstream already and the rest applied without conflict...

> 
> Tested-by: Coiby Xu <coxu@redhat.com>

Thanks.
