Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963125B7862
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 19:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiIMRmN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiIMRlu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 13:41:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F3C201A2
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 09:34:57 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DFglE8024272;
        Tue, 13 Sep 2022 16:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=c6Udem6pb691JTyekwObmtpp8nxlbFTAr/ZLU1ShmwA=;
 b=Z6vvG/YUyfw1FCI4SwFByY7vn1ROcash7KkaV3JVRXOHaOm/9HiHuIgOzeungeshguDt
 y/0oDu0YRCPcZPl17CDruBioPoj1kzUVjSh5Gb4a4uBBikgQUSM5/OWND8/G9IVes3B0
 SubHn669Xfx0cwOasaP2m3zfxbZm5/rnjuzmB4mtni+QfLjBhfxB+ek+0WIb7l6HPWUw
 bItc8YhgZMbzCsUjS8QzYCsXDGWHMf4ZxUTw5H/LM1XOV8dvICJcm+EuBboQTUvBm4ml
 oZY9Xq04EUhB5iGXTlzoq0yyjeXeb+KML5GXjGHdb5YEBeEK1LkdpmjV8kqT37zgUWDL pQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jjvark7tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 16:34:50 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28DGL62i016151;
        Tue, 13 Sep 2022 16:34:49 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 3jgj79w5ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 16:34:49 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28DGYnSB1114724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:34:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E6FFB2064;
        Tue, 13 Sep 2022 16:34:49 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2879B205F;
        Tue, 13 Sep 2022 16:34:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Sep 2022 16:34:45 +0000 (GMT)
Message-ID: <296d6f8a-ea43-25d8-53fa-0184cf63a71b@linux.ibm.com>
Date:   Tue, 13 Sep 2022 12:34:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v2 11/12] Missing template data size lower
 bounds checking
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
 <20220906195021.854090-12-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220906195021.854090-12-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZAet-0NKkfzY_JxXO_oygrM_Wg_StJIt
X-Proofpoint-ORIG-GUID: ZAet-0NKkfzY_JxXO_oygrM_Wg_StJIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209130075
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/6/22 15:50, Mimi Zohar wrote:
> Each record in the IMA measurement list must contain some template data.
> Ensure the template data is not zero length.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   src/evmctl.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index aac669438a1c..e603449b7d9e 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2188,6 +2188,10 @@ static int ima_measurement(const char *file)
>   				log_err("Unable to read template length\n");
>   				goto out;
>   			}
> +			if (entry.template_len == 0) {
> +				log_err("Invalid template data len\n");
> +				goto out;
> +			}
>   		} else {
>   			entry.template_len = SHA_DIGEST_LENGTH +
>   					     TCG_EVENT_NAME_LEN_MAX + 1;
