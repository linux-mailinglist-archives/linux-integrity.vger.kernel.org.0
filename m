Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F884BD29D
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 00:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245232AbiBTXUo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 18:20:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiBTXUn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 18:20:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691722C11A;
        Sun, 20 Feb 2022 15:20:21 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21KGlOlN027877;
        Sun, 20 Feb 2022 23:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=WalQmBmZDHc62f4OE0+VIiS7BEIhT60ZacvAOX9Q9ww=;
 b=WGhk4SmmRh/f1xiUBo0jKfBemQwWt+aQEiB+ThnsTmJJlrRdZ9MAIU9KNZtJNL5y5dQB
 jo1YALS8sRpUTY+FHCGJAkuz99+2CRnDiVlj5t/oiMsii5bJ8fqlLWcq7ZQv17f5sy0b
 GHdrOVE7xIDu6A/8pFUnApsiUhXuBQzIRifnhBt19prM/dSMAKtrk+FnNw/pKvBhLErj
 i2/jK7v0MLKvqfDmptQY1l1zvYEuxGBjjlHM5toK8jOIRj6IGNMwUCdSBUe7nLNrSx4G
 7RYoyXpF9W1iorsMRWEodry+o8tVCgGf+6zwI0x6vrkM8ejVdT+Y7aHX8KokRIk+Sh/2 AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ebsfk3unk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Feb 2022 23:20:05 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21KNK5S0031649;
        Sun, 20 Feb 2022 23:20:05 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ebsfk3un4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Feb 2022 23:20:05 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21KNDkEL025911;
        Sun, 20 Feb 2022 23:20:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3ear68wrch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Feb 2022 23:20:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21KNK0YU50266578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Feb 2022 23:20:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3AA1AE04D;
        Sun, 20 Feb 2022 23:20:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAA57AE045;
        Sun, 20 Feb 2022 23:19:59 +0000 (GMT)
Received: from sig-9-65-90-122.ibm.com (unknown [9.65.90.122])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 20 Feb 2022 23:19:59 +0000 (GMT)
Message-ID: <07a65960197c4b50f996abdf2b062e836ce1226d.camel@linux.ibm.com>
Subject: Re: init_ima() adds 8 % to boot time
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Petr Vorel <pvorel@suse.cz>
Date:   Sun, 20 Feb 2022 18:19:59 -0500
In-Reply-To: <YhLHZeQdaIKHexVd@iki.fi>
References: <32f90c33-eeb9-64a0-b2e2-9258ba2e1820@molgen.mpg.de>
         <7d84425f36e3b04ab1adabed23f98b478b53b770.camel@linux.ibm.com>
         <YhLHZeQdaIKHexVd@iki.fi>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7AlreKb2QpztoMehMrNl39cWW8FRb7GN
X-Proofpoint-GUID: vgL869rMjIqqMex1ZIANoHAigw1yvcgv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-20_10,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202200151
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2022-02-20 at 23:57 +0100, Jarkko Sakkinen wrote:
> On Sun, Feb 20, 2022 at 10:19:37AM -0500, Mimi Zohar wrote:
> > [Cc'ing Jarkko, Petr Vorel]
> > 
> > Hi Paul,
> > 
> > On Sat, 2022-02-19 at 10:44 +0100, Paul Menzel wrote:
> > > Dear Linux folks,
> > > 
> > > 
> > > Debian builds its Linux kernel image with `CONFIG_IMA=y` since version 
> > > 5.13.9 [1]. Unfortunately, on the Dell Latitude E7250 `init_ima` takes 
> > > around 33 ms, adding 8 % to the boot time up to loading the initrd.
> > > 
> > >      [    0.000000] Linux version 5.17.0-rc4-amd64 
> > > (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-16) 11.2.0, GNU 
> > > ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT Debian 5.17~rc4-1~exp1 
> > > (2022-02-18)
> > >      […]
> > >      [    0.238520] calling  init_tis+0x0/0xde @ 1
> > >      [    0.254749] tpm_tis 00:08: 1.2 TPM (device-id 0x3205, rev-id 80)
> > >      [    0.285665] initcall init_tis+0x0/0xde returned 0 after 46038 usecs
> > >      […]
> > >      [    0.301327] calling  init_ima+0x0/0xb5 @ 1
> > >      [    0.301332] ima: Allocated hash algorithm: sha256
> > >      [    0.335502] ima: No architecture policies found
> > >      [    0.335520] initcall init_ima+0x0/0xb5 returned 0 after 33389 usecs
> > >      […]
> > >      [    0.447312] Run /init as init process
> > > 
> > > Tracing `init_ima` with a depth of 5 shows 
> > > `ima_calc_boot_aggregate_tfm()` takes 24 ms, and 
> > > `ima_add_template_entry()` takes 10 ms.
> > > 
> > >          1.282630 |   1)   swapper-1    |               | 
> > > ima_add_boot_aggregate() {
> > >          1.282631 |   1)   swapper-1    |               | 
> > > ima_calc_boot_agg:0regate() {
> > >          1.282631 |   1)   swapper-1    |   0.153 us    | 
> > > ima_alloc_tfm();
> > >          1.282631 |   1)   swapper-1    | * 24404.59 us | 
> > > ima_calc_boot_aggregate_tfm();
> > >          1.307037 |   1)   swapper-1    |   0.482 us    | 
> > > ima_free_tfm.part.0();
> > >          1.307038 |   1)   swapper-1    | * 24407.06 us |        } /* 
> > > ima_calc_boot_aggregate */
> > >          1.307038 |   1)   swapper-1    |               | 
> > > ima_alloc_init_template() {
> > >          1.307038 |   1)   swapper-1    |   0.173 us    | 
> > > ima_template_desc_current();
> > >          1.307039 |   1)   swapper-1    |   0.836 us    | 
> > > __kmalloc();
> > >          1.307040 |   1)   swapper-1    |   0.580 us    | 
> > > __kmalloc();
> > >          1.307041 |   1)   swapper-1    |   1.555 us    | 
> > > ima_eventdigest_ng_init();
> > >          1.307043 |   1)   swapper-1    |   1.275 us    | 
> > > ima_eventname_ng_init();
> > >          1.307044 |   1)   swapper-1    |   0.256 us    | 
> > > ima_eventsig_init();
> > >          1.307045 |   1)   swapper-1    |   6.618 us    |        } /* 
> > > ima_alloc_init_template */
> > >          1.307045 |   1)   swapper-1    |               | 
> > > ima_store_template() {
> > >          1.307045 |   1)   swapper-1    |   5.049 us    | 
> > > ima_calc_field_array_hash();
> > >          1.307051 |   1)   swapper-1    | # 9316.953 us | 
> > > ima_add_template_entry();
> > >          1.316369 |   1)   swapper-1    | # 9323.728 us |        } /* 
> > > ima_store_template */
> > >          1.316369 |   1)   swapper-1    | * 33738.54 us |      } /* 
> > > ima_add_boot_aggregate */
> > > 
> > > Tracing `ima_calc_boot_aggregate_tfm()` (attached) shows that the first 
> > > `tpm1_pcr_read()` takes 16 ms in `tpm_transmit()`. Is communicating with 
> > > the TPM supposed to be that slow?
> > > 
> > > In the last years, Linux decreased it’s boot time a lot, so do you see a 
> > > way to move things out of the hot path and get `init_ima` well below 10 
> > > ms? (As systems get faster and faster, having systems with standard 
> > > distributions to be up below two seconds after pressing the power button 
> > > should be a reasonable goal (500 ms firmware (like coreboot) + 500 ms 
> > > Linux kernel + 1 s user space).
> > > 
> > > 
> > > [1]: 
> > > https://salsa.debian.org/kernel-team/linux/-/commit/6e679322d7d98d30b4a8a3d1b659c899a6e9d4df
> > 
> > Thank you including the initial and other TPM delays.  The main reason
> > for the "boot_aggregate" is to tie the pre-OS measurements to the post
> > OS measurement list.  Without the TPM based 'boot_aggregate', any IMA
> > measurement list could be used to verify a TPM quote.  The
> > 'boot_aggregate' is calculated, originally, based on PCRs 0 - 7 and
> > more recently may include PCRs 8 & 9 as well.  The 'boot_aggregate' is
> > the first record in the IMA measurement list and the first record after
> > a soft reboot (kexec).  It is the one and only IMA measurement record
> > not dependent on policy.
> > 
> > There are TPM 1.2 & 2.0 standards' requirements, but there are also
> > buggy TPMs which don't adhere to them to such an extent that IMA goes
> > into 'TPM-bypass' mode. Perhaps for those not interested in extending
> > the concepts of trusted boot to the running OS, defining a new boot
> > command line option to force IMA into this 'TPM-bypass' mode would be
> > an acceptable alternative to the delay.  The IMA measurement list would
> > still include a 'boot_aggregate' record, but one containing 0's.
> 
> I support the opt-in boot option.
> 
> If the full hardware specifications are known for a device, you might want
> to use this.

The default would be to extend the TPM with the 'boot_aggregate', with
an option to opt-out of extending the TPM.

-- 
thanks,

Mimi


