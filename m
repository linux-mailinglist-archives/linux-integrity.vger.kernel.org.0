Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6C274B390
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jul 2023 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjGGPDP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jul 2023 11:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjGGPDO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jul 2023 11:03:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809471FE2
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jul 2023 08:03:13 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367EqJX8030176;
        Fri, 7 Jul 2023 15:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=e4L2IAnPOuCma6RJoU3QN8PWjT78HhgqR2PhYWPWuDg=;
 b=l5Sc+o6uFol8YlkTS6zHzuqqyEnGMVIc1OhbY366Ej0Zxpe4oJpjRATAyCFKIRQdg/tO
 7sGARC5GiLKmSIXfqA8AZH7q5t91g8odbVpV+I3LrqkR1oBPTWrLsdH3Fs2x4shcNhd2
 Gh71tVznf38fE4RiZvcAH76H1vMrAqgjhATla3rmbliv0wcAfaKoTFp/Rcy1p9MC+MeI
 CkduvKP0RbmuGcvjeYgqAFmJkoqvQjk0a755nGTfSWszJFuWbL72m/e8nip09+gj1Hx3
 lwkvFqStxpS8VcgiDgVvQQJIrozW+aAoggIjbegPi7lhrOV1wP9uWb+P/EYOJBASQPwz +w== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpmuhr7jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 15:02:51 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 367Ag2Rc022997;
        Fri, 7 Jul 2023 15:01:50 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3rjbs5wwmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 15:01:50 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367F1ndi64356838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 15:01:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D89E5805E;
        Fri,  7 Jul 2023 15:01:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1B9258051;
        Fri,  7 Jul 2023 15:01:48 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.7.157])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 15:01:48 +0000 (GMT)
Message-ID: <5cd5b5efc443cbdce9dce3b121f4dbfd2db6dea3.camel@linux.ibm.com>
Subject: Re: [PATCH 06/10] ima: update buffer at kexec execute with ima
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Fri, 07 Jul 2023 11:01:48 -0400
In-Reply-To: <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
         <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S_68gnkbdCDoAkCtxBx-RJ6sGlfqDlYw
X-Proofpoint-ORIG-GUID: S_68gnkbdCDoAkCtxBx-RJ6sGlfqDlYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxlogscore=956
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070139
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:

> +/*
> + * Called during kexec execute so that IMA can update the measurement list.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				   unsigned long action, void *data)
> +{
> +	void *new_buffer = NULL;
> +	size_t new_buffer_size, cur_buffer_size;
> +	bool resume = false;
> +
> +	if (!kexec_in_progress) {
> +		pr_info("%s: No kexec in progress.\n", __func__);
> +		return NOTIFY_OK;
> +	}
> +
> +	if (!ima_kexec_buffer) {
> +		pr_err("%s: Kexec buffer not set.\n", __func__);
> +		return NOTIFY_OK;
> +	}
> +
> +	ima_measurements_suspend();
> +
> +	cur_buffer_size = kexec_segment_size - sizeof(struct ima_kexec_hdr);
> +	new_buffer_size = ima_get_binary_runtime_size();
> +	if (new_buffer_size > cur_buffer_size) {
> +		pr_err("%s: Measurement list grew too large.\n", __func__);
> +		resume = true;
> +		goto out;
> +	}

This changes the current behavior of carrying as many measurements
across kexec as possible.  True the measurement list won't verify
against the TPM PCRs, but not copying the measurements leaves the
impression there weren't any previous measurements.

This also explains the reason for allocating an IMA buffer (patch 1/10)
and not writing the measurements directly into the kexec buffer.

> +	ima_populate_buf_at_kexec_execute(&new_buffer_size, &new_buffer);
> +
> +	if (!new_buffer) {
> +		pr_err("%s: Dump measurements failed.\n", __func__);
> +		resume = true;
> +		goto out;
> +	}
> +	memcpy(ima_kexec_buffer, new_buffer, new_buffer_size);
> +out:
> +	kimage_unmap_segment(ima_kexec_buffer);
> +	ima_kexec_buffer = NULL;
> +
> +	if (resume)
> +		ima_measurements_resume();
> +
> +	return NOTIFY_OK;
> +}
> +
>  #endif /* IMA_KEXEC */
>  
>  /*

-- 
thanks,

Mimi

