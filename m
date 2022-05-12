Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3FB52558E
	for <lists+linux-integrity@lfdr.de>; Thu, 12 May 2022 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiELTPC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 15:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357934AbiELTO7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 15:14:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B299A2764EA
        for <linux-integrity@vger.kernel.org>; Thu, 12 May 2022 12:14:58 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CIjvnc009116;
        Thu, 12 May 2022 19:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kVVaIWakM5cPLgUPxQvMa6W7uxsXGPzyO/z1HJkmhTo=;
 b=KCdHK9pX/+K5aUzYmYJWLY7NzT1/UW1qBSMOSrjh88/T5O8KQMRiVQ5Q4kcqy8yvnJsv
 WgzkL2A7N89lrAy5IgFfJnzmLii6OGqYUItD7poxpp3tsUdw/lHthePbKJ2X7UVwjPaa
 24lFM/jVMBIfMdVZ6z9sWA66uoQ2zjOHddNC7p+7ktuQeJ4iB2AjLaXMN/iQasXyl73D
 OwZeXyCJKvdVr2s/OWi+Oz3uZIrza3ZbuQ4BE9F/0ARekppv41/zLYkfBbCA87cvcryX
 /7tx4pOD7IYooocKNxKPPBFL82WTG09VC0+nU/JppfVAHjSMaRm3PK3K2spDtmI9NOjL Ew== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g17t60fnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:14:55 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CIvVB0008884;
        Thu, 12 May 2022 19:14:55 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 3fwgdadd9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 19:14:55 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CJEs0G11207088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 19:14:54 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E8216E054;
        Thu, 12 May 2022 19:14:54 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D766E6E050;
        Thu, 12 May 2022 19:14:53 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 19:14:53 +0000 (GMT)
Message-ID: <5a5ff8ae-f99a-e717-bdd4-601774f1692e@linux.ibm.com>
Date:   Thu, 12 May 2022 15:14:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 ima-evm-utils 1/3] initialize errno in cmd_sign_hash()
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Eric Biggers <ebiggers@kernel.org>
References: <20220512183056.307597-1-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220512183056.307597-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dyKlvgqQKDjPbI8J9BSJ3rj9QzUjfWOI
X-Proofpoint-GUID: dyKlvgqQKDjPbI8J9BSJ3rj9QzUjfWOI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_16,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120083
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/12/22 14:30, Mimi Zohar wrote:
> Prevent "errno: No such file or directory (2)" message.

I guess there's an error being returned from call_command() but this 
errno is unrelated or confusing. Maybe errno should be initialized at 
the beginning of main() or beginning of call_command() to clear it 
before any command is run that can return an error and where the errno 
may be confusing the user otherwise.

> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   src/evmctl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 8bdd34817408..ca9449498321 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -737,6 +737,7 @@ static int cmd_sign_hash(struct command *cmd)
>   	unsigned char sig[MAX_SIGNATURE_SIZE] = "\x03";
>   	int siglen;
>   
> +	errno = 0;
>   	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
>   
>   	/* support reading hash (eg. output of shasum) */
