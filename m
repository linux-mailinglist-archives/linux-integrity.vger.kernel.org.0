Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2955163AEAC
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 18:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiK1RQi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 12:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiK1RQa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 12:16:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7187525E87;
        Mon, 28 Nov 2022 09:16:29 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ASFvbRZ032038;
        Mon, 28 Nov 2022 17:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RZJVGDX/6B5Oe0iNQFvKjIT62omfWmQKvG7j7+mkPXg=;
 b=K3Iy9/sJ/sx1tmzXN7yRnRY+uDt7IvrHNw05L6MvmciQAs3HawKBYsgTo8427zAmPH+F
 IMRqOtQayO6L/xm44knAHK2uDCaE4mFfkPcEKAxYNZfbtobPQ96ELI9xAQVIcelO/TBm
 KEXMv1TjyK7DVSEhRctWywQEcijWuasrXB6IfqQIPCbK5WQx1CbN3HddcVaECwWi8yfA
 xgmMSpvggCAK1wtz+yNryWivvRps9BRpbiKzd/QQSJA+JLNkwansm1crg0zn0X+GmOmO
 YyVP5S0nNh7YUrpQNXnBHRWZvL/O4bAdeJr//XiPHC7XZy5XLFrMrh/fk1AngH0viBKt EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3vjdfpg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 17:16:12 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ASGrMPK002723;
        Mon, 28 Nov 2022 17:16:12 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3vjdfpf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 17:16:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ASH9NBV027840;
        Mon, 28 Nov 2022 17:16:10 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 3m3ae9tmf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Nov 2022 17:16:10 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ASHG5Sv23724522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Nov 2022 17:16:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 098E958055;
        Mon, 28 Nov 2022 17:16:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DC3058043;
        Mon, 28 Nov 2022 17:16:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.26.105])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 28 Nov 2022 17:16:08 +0000 (GMT)
Message-ID: <2204915d319ff9acf80f68ccba8600aaeb5578d7.camel@linux.ibm.com>
Subject: Re: [PATCH] lockdown: kexec_file: prevent unsigned kernel image
 when KEXEC_SIG not enabled
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, Matthew Garrett <mjg59@srcf.ucam.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>,
        Matthew Garrett <mjg59@google.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 28 Nov 2022 12:16:08 -0500
In-Reply-To: <20221122023606.nrifkrng5nbfmkka@Rk>
References: <20221121072947.836672-1-coxu@redhat.com>
         <5d98172d77a8a0f1e3daab44ad51bf38978cc053.camel@linux.ibm.com>
         <20221122023606.nrifkrng5nbfmkka@Rk>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mqijHTnZy1VBf3pmbGa_r2tIH2ydgGu9
X-Proofpoint-ORIG-GUID: irI5J7NUXvt-rvRcC-babNVDtv_cJtnT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_14,2022-11-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=709 bulkscore=0 spamscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211280126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-11-22 at 10:36 +0800, Coiby Xu wrote:
> Hi Mimi,
> 
> On Mon, Nov 21, 2022 at 01:23:57PM -0500, Mimi Zohar wrote:
> >Hi Coiby,
> >
> >On Mon, 2022-11-21 at 15:29 +0800, Coiby Xu wrote:
> >> A kernel builder may not enable KEXEC_SIG and some architectures like
> >> ppc64 simply don't have KEXEC_SIG. In these cases, unless both
> >> IMA_ARCH_POLICY and secure boot also enabled, lockdown doesn't prevent
> >> unsigned kernel image from being kexec'ed via the kexec_file_load
> >> syscall whereas it could prevent one via the kexec_load syscall. Mandate
> >> signature verification for those cases.
> >>
> >> Fixes: 155bdd30af17 ("kexec_file: Restrict at runtime if the kernel is locked down")
> >> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> >> Cc: Jiri Bohac <jbohac@suse.cz>
> >> Cc: David Howells <dhowells@redhat.com>
> >> Cc: kexec@lists.infradead.org
> >> Cc: linux-integrity@vger.kernel.org
> >> Signed-off-by: Coiby Xu <coxu@redhat.com>
> >
> >Other than correcting the function name to mandate_signature_verificati
> >on(),
> 
> Applied to v2, thanks for correcting me! Btw, I realize I overwrote the
> return code of kexec_image_verify_sig with
> mandate_signature_verification's. v2 has fixed this issue as well.
> 
> >
> >Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> And thanks for the review!

You're welcome.

Without either IMA_ARCH or KEXEC_SIG enabled, the kexec selftest
test_kexec_file_load.sh properly failed with "kexec_file_load failed
[PASS]", but from the informational messages output, it isn't clear why
it failed.  This should be corrected.

-- 
thanks,

Mimi

