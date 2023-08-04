Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E4376F6DA
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 03:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjHDBTa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 21:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjHDBT3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 21:19:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E684204
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 18:19:28 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3741E0cH014695;
        Fri, 4 Aug 2023 01:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hRUuYNEq51IISWThNxB+vhPcosarWEeayDJatL6s9sw=;
 b=WWY2+GKt7w5MupIYGoCGocA/Ggw23FbNHEy6v3UA0XzLbI4ZPT+tXchsyZNejTn4isp7
 4BMx6KYgp8Elhhzk6kYJ9wTAtMVXc4sZ4f4LTPCNGv8mY/Wsda4fVoxm/Qzem0hqrIqg
 Xu47cQSId54hWoyGQJtqAoGi0EFPDDtTk9Z1BhWgTKaoIhFOEyA91gwkQSnnyw01wk4m
 XSUOUq9smUPvbYgEQwO0I8AwbL/LhxDmSYC8ivr+Q1XxmnqDHZwxdkt/9XKlHFV1qB63
 x/KLN2chrXUblnh+BpXewh54eXj0O/uzf3OUsY4pm5MffE1vfamJ4ww2otdauxIwttkq gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8qfyr2ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 01:19:02 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3741J10t030442;
        Fri, 4 Aug 2023 01:19:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8qfyr2kc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 01:19:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373NIQjC021591;
        Fri, 4 Aug 2023 01:19:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s8kmc9hfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 01:19:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3741Ix4d36962606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 01:18:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C93825805C;
        Fri,  4 Aug 2023 01:18:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C85A5805E;
        Fri,  4 Aug 2023 01:18:58 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.157.226])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  4 Aug 2023 01:18:58 +0000 (GMT)
Message-ID: <e9ab98a823c2e6c536fb2acbe86229a0085bd34a.camel@linux.ibm.com>
Subject: Re: [PATCH 5/6] ima: measure TPM update counter at ima_init
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Thu, 03 Aug 2023 21:18:57 -0400
In-Reply-To: <da91b56a-83c8-d12e-71f8-887b6701f021@linux.microsoft.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
         <20230801181917.8535-6-tusharsu@linux.microsoft.com>
         <223d5c5a655fec263895c991550e4291d1bbd4c9.camel@linux.ibm.com>
         <da91b56a-83c8-d12e-71f8-887b6701f021@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l0uqTI1WZecOJcWxJijVFSnp-7m7iNtC
X-Proofpoint-GUID: kjX9wFxSgO1ykwjMMn4_nXrKNvZFRrJn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_24,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040007
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-08-03 at 16:34 -0700, Tushar Sugandhi wrote:

> >> +++ b/security/integrity/ima/ima_init.c
> >> @@ -154,5 +154,8 @@ int __init ima_init(void)
> >>   				  UTS_RELEASE, strlen(UTS_RELEASE), false,
> >>   				  NULL, 0);
> >>   
> >> +	/* Measures TPM update counter at ima_init */
> >> +	ima_measure_update_counter("ima_init_tpm_update_counter");
> >> +
> > With "ima_policy=critical_data" on the boot command line, the IMA
> > measurement list record looks like:
> >
> > 6e190cc643ff0b718485966a0300473baedface735 ima_init_tpm_update_counter 7570646174655f636f756e7465723d3330383b
> >
> > Please change the "ima_init_tpm_update_counter" to something shorter
> > and the hex encoded ascii string and pcr counter to something readable.
> I believe you are seeing the above line in ascill_runtime_measurements log.

Yes, the ascii_runtime_measurements are suppose to be readable to the
end user.

> The ascii logging format is consistent with other event data for 
> critical_data event e.g. kernel_version.

Then you got it wrong.

> 10 8f449175bbf88bc55fc1127466628c39a3957d15 ima-buf 
> sha1:4acab4fbb08db663b7b7b4528e8729187d726782 kernel_version 
> 362e332e302d7263332b
> 10 f10678b63c4b2529339dff02282e63d9c6bb0385 ima-buf 
> sha1:d8c187524412f74a961f2051a9529c009e700337 
> ima_init_tpm_update_counter 7570646174655f636f756e7465723d3133303b
> 
> Entries in the binary runtime measurements look readable to me.

You've inverted the meaning of the ascii and binary runtime measurement
lists.  For comparison look at the ima-ng/ima-sig records.

> ima_init_tpm_update_counter update_counter=130;
> ...
> kexec_load_tpm_update_counte rupdate_counter=133;
> 
> Please let me know if you still want me to change the format.

OI course the ascii measurement list should be human readable.

> > Perhaps name this critical-data "tpm" and "tpm-info", similar to the
>  From patch 4/6:
> +    result = ima_measure_critical_data("tpm_pcr_update_counter", 
> event_name,
> +                  buf, buf_len, false, NULL, 0);
> 
> The critical_data event_label value is currently set to 
> "tpm_pcr_update_counter".

Why is the string so long?   Long strings or variables don't make the
code or logs more understandable.  Please shorten both the strings and
variables.

> I can rename event_label to "tpm-info", so that the admins can filter the
> event in IMA policy based on the label if needed.

The new record needs to be self containd and verifiable.  The
additional info I suggested were just examples.  Please take the time
to consider what needs to be included in the new record.  Decide
whether this is a TPM security critical data record.  Only then, decide
on the naming.

-- 
thanks,

Mimi


