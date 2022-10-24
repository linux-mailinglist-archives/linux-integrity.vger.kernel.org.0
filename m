Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34A060BDBC
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Oct 2022 00:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJXWp5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Oct 2022 18:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiJXWpO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Oct 2022 18:45:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53D12D73A4;
        Mon, 24 Oct 2022 14:07:52 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OFiKHD013992;
        Mon, 24 Oct 2022 16:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9wlCDw+a92Up+pNrRo8zuQis24dtp7D6jbFeA0gp0gw=;
 b=qdgKqcJSj+bMm3DkLvph+E3vGxZH1axYA8Bt7sFFoV3RwPioi8BLmPkA3S9UY/6opKmW
 hKmwbo1h1LcSbN5M1TaOK5S/vwmJ1eNFrhLAIJd1H4SCmJXUX0uRhTvwmrCg1iCX6P0c
 hjkhsW6RAgzUmuzYcpWQpl3zDg/V0fO2h8aLSTQeFGs343osV1yyvapGLcPtWDLCdHDS
 XcidvftAr9wBhAYHLb/UD2zKFIUIJHK+NCSP0X8TZrSUkgLi5MOKLPgUgYmabC8PRPJb
 zco/tw0UMbyfrZJzXfkq1dPEE1DQ2LZTsaUQw+yn7OkrqrkkjeYToU4YOIA4Fhskx5hX rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kdwkvssuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 16:35:58 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29OFjWnt029391;
        Mon, 24 Oct 2022 16:35:57 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kdwkvsstc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 16:35:57 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29OGZGKF028827;
        Mon, 24 Oct 2022 16:35:56 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 3kc859cek6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 16:35:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com ([9.208.128.116])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29OGZtEk42074504
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 16:35:56 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A1D858061;
        Mon, 24 Oct 2022 16:35:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDC0558052;
        Mon, 24 Oct 2022 16:35:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.81.179])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Oct 2022 16:35:52 +0000 (GMT)
Message-ID: <8607d166bbd2f32f1e71e5d7ce40b937eaeb410b.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, casey@schaufler-ca.com, davem@davemloft.net,
        lucien.xin@gmail.com, vgoyal@redhat.com, omosnace@redhat.com,
        mortonm@chromium.org, nicolas.bouchinet@ssi.gouv.fr,
        mic@digikod.net, cgzones@googlemail.com,
        linux-security-module@vger.kernel.org, brauner@kernel.org,
        keescook@chromium.org
Date:   Mon, 24 Oct 2022 12:35:52 -0400
In-Reply-To: <Y1Ki8838IAicXzlb@archlinux>
References: <Y1FTSIo+1x+4X0LS@archlinux>
         <5edef60c775117758ecc146f1e8b96ef1c48e3da.camel@linux.ibm.com>
         <Y1Ki8838IAicXzlb@archlinux>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Es21pzRSpsp6z_BCntxy0o-1MK-A8XXE
X-Proofpoint-GUID: Orq17um0MvG2F1CBFAvPDpUSRrML2Ima
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_05,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Nicolas,

On Fri, 2022-10-21 at 15:47 +0200, Nicolas Bouchinet wrote:
> Hi Mimi,
> 
> Thanks for the IMA/EVM project which I enjoy very much.
> 
> On Thu, Oct 20, 2022 at 03:51:38PM -0400, Mimi Zohar wrote:
> > On Thu, 2022-10-20 at 15:55 +0200, Nicolas Bouchinet wrote:
> > > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > > 
> > > Fixes a NULL pointer dereference occuring in the
> > > `evm_protected_xattr_common` function of the EVM LSM. The bug is
> > > triggered if a `inode_init_security` hook returns 0 without initializing
> > > the given `struct xattr` fields (which is the case of BPF) and if no
> > > other LSM overrides thoses fields after. This also leads to memory
> > > leaks.
> > > 
> > > Adds a `call_int_hook_xattr` macro that fetches and feed the
> > > `new_xattrs` array with every called hook xattr values.
> > > 
> > > Adds a `evm_init_hmacs` function which init the EVM hmac using every
> > > entry of the array contrary to `evm_init_hmac`.
> >   
> > Only EVM portable digital signatures include all of the protected
> > xattrs.   Refer to commit 8c7a703ec978 ("evm: Verify portable
> > signatures against all protected xattrs").
> > 
> Sorry, maybe I was not clear enough, the proposed patch does not change the
> set of the protected security xattrs initialized by the LSMs and processed by EVM.
> 
> As I explained to Paul, based on my understanding, the `security_inode_init_security()`
> hook is supposed to initialize every hooked LSM security xattr and next,
> if evm is enabled, protect them using a HMAC algorithm.
> However, in the current implementation, the use of the `call_int_hook()` macro by
> `security_inode_init_security()` overwrites the previously initialized xattr for
> each iteration of the `hlist_for_each_entry()` loop.
> 
> I have noticed that more than one LSM may initialize a security xattr at a time,
> eg. SELinux + BPF.

Does BPF have a security xattr and, if so, does it need to be
protected?   It would need to be defined and included in the list of
evm_config_xattrnames[].  If it doesn't define a security bpf xattr,
then bpf should not be on the security_inode_init_security() hook.  (I
assume Roberto's patch is going in this direction.)

Before the EVM hmac is updated, the existing EVM hmac is verified.  I
would be concerned if bpf defined a protected security xattr.   Could
the same guarantees, that security.evm isn't updated without first
being verified, be enforced with bpf?

> 
> IMHO my supplementary `evm_init_hmacs()` function name is a bit confusing, I would
> enjoy if you have a better proposition. Note that `evm_init_hmacs()` have the same
> behavior as `evm_init_hmac()` if only one security xattr is given as a parameter.

I'm missing something here.  As evm_inode_init_security() is the only
caller of evm_init_hmac(), why is a new function defined instead of
updating the existing one?   If there is a valid reason, then one
function should be a wrapper for the other.

> > > 
> > > Fixes the `evm_inode_init_security` function to use `evm_init_hmacs`.
> > 
> > Won't this break existing EVM hmac usage?
> I might be wrong, but as far as I understand it, the only working condition for
> EVM now is when only one security xattr is involved, otherwise there will have
> a mismatch between the initialization and the verification.
> Indeed, the verification takes into account every security xattr written in its
> refering dentry.

Agreed, independently as to whether BPF defines a security xattr, if
two LSMs initialize security xattrs, then this change is needed.  Are
there any other examples?

(nit: I understand the line size has generally been relaxed, but for
IMA/EVM I would prefer it to be remain as 80 chars.)

Mimi

