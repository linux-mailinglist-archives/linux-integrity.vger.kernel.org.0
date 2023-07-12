Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00395750CED
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Jul 2023 17:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbjGLPpe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Jul 2023 11:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjGLPpd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jul 2023 11:45:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B0510C4
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jul 2023 08:45:32 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CFgZ2o028515;
        Wed, 12 Jul 2023 15:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=d08nYyuveInuFgoMGYmyl5DZ69xKe06D0LuDLAxx+TA=;
 b=jXXyHBuq88hmCX4ELu9BdxxUmzmaqqa/HNdJZb0HFugkr+2oTwl+oe34pLLyW2UbbzxQ
 bGky26u7I9PhM1UFHbtGb1ufelWt4oV5Fpkc9LVYzFK8vYcRPgW0JICoBgcWb9C3gESd
 qQ05S0BXkux6l0ttIAYQdVkdNtPc7eLRTiOWPFne6WMJmb3+AD1l/ZSUbn+alYJqvk2C
 A1/9qgN0LH+mQQAEuHInQPy0HU4ovqtanW5WBjRzdxIgOjCmjn0MfLg7eV4gE2094zAz
 RNtyYpT5zcnnqj1+v2N5TJ9eUrmPUWyCfvWDCaorCSJs3gk3BpKQaFSTCPZRP3ZwKG8+ Dw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsy28g3gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 15:45:14 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36CC04nH014032;
        Wed, 12 Jul 2023 15:45:11 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3rpye5v94e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 15:45:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CFj9x853608954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 15:45:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97B9658056;
        Wed, 12 Jul 2023 15:45:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C77C58068;
        Wed, 12 Jul 2023 15:45:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.165.208])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jul 2023 15:45:08 +0000 (GMT)
Message-ID: <0adc4f1754dcbb0412603f48c18bebb25a6cd2a8.camel@linux.ibm.com>
Subject: Re: [PATCH 06/10] ima: update buffer at kexec execute with ima
 measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
        Eric Biederman <ebiederm@xmission.com>
Date:   Wed, 12 Jul 2023 11:45:08 -0400
In-Reply-To: <9b7db004-0517-9163-e9d5-9555b416144c@linux.microsoft.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
         <20230703215709.1195644-7-tusharsu@linux.microsoft.com>
         <5cd5b5efc443cbdce9dce3b121f4dbfd2db6dea3.camel@linux.ibm.com>
         <a3f141d0585580676e6738ff6596dad106f7bf18.camel@linux.ibm.com>
         <9b7db004-0517-9163-e9d5-9555b416144c@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F-SZoSHOURCe-sivmwFw1NYco2UGjrX5
X-Proofpoint-GUID: F-SZoSHOURCe-sivmwFw1NYco2UGjrX5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 mlxlogscore=922 priorityscore=1501 mlxscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120141
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-07-11 at 12:08 -0700, Tushar Sugandhi wrote:
> Adding Eric to cc.
> 
> On 7/7/23 12:49, Mimi Zohar wrote:
> > On Fri, 2023-07-07 at 11:01 -0400, Mimi Zohar wrote:
> >> Hi Tushar,
> >>
> >> On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
> >>
> >>> +/*
> >>> + * Called during kexec execute so that IMA can update the measurement list.
> >>> + */
> >>> +static int ima_update_kexec_buffer(struct notifier_block *self,
> >>> +				   unsigned long action, void *data)
> >>> +{
> >>> +	void *new_buffer = NULL;
> >>> +	size_t new_buffer_size, cur_buffer_size;
> >>> +	bool resume = false;
> >>> +
> >>> +	if (!kexec_in_progress) {
> >>> +		pr_info("%s: No kexec in progress.\n", __func__);
> >>> +		return NOTIFY_OK;
> >>> +	}
> >>> +
> >>> +	if (!ima_kexec_buffer) {
> >>> +		pr_err("%s: Kexec buffer not set.\n", __func__);
> >>> +		return NOTIFY_OK;
> >>> +	}
> >>> +
> >>> +	ima_measurements_suspend();
> >>> +
> >>> +	cur_buffer_size = kexec_segment_size - sizeof(struct ima_kexec_hdr);
> >>> +	new_buffer_size = ima_get_binary_runtime_size();
> >>> +	if (new_buffer_size > cur_buffer_size) {
> >>> +		pr_err("%s: Measurement list grew too large.\n", __func__);
> >>> +		resume = true;
> >>> +		goto out;
> >>> +	}
> >> This changes the current behavior of carrying as many measurements
> >> across kexec as possible.  True the measurement list won't verify
> >> against the TPM PCRs, but not copying the measurements leaves the
> >> impression there weren't any previous measurements.
> >>
> >> This also explains the reason for allocating an IMA buffer (patch 1/10)
> >> and not writing the measurements directly into the kexec buffer.
> > If not carrying even a partial measurement list across kexec is
> > desired, then in addition to the "boot_aggregate" record, define a new
> > record containing the TPM pcrcounter.  With this information,
> > attestation servers will at least be able to detect if the measurement
> > list was truncated.

> Sure.  Recording TPM pcrcounter at boot aggregate and
> Kexec 'load' should provide the necessary information to the
> attestation servers.  We can implement this if needed, based on how
> rest of the series evolves.

Recording the TPM pcrcounter should be done independently of this patch
set.  This patch set would have a dependency on it.

-- 
thanks,

Mimi

