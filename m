Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BFA12095
	for <lists+linux-integrity@lfdr.de>; Thu,  2 May 2019 18:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEBQxX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 May 2019 12:53:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726236AbfEBQxX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 May 2019 12:53:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42GgCAx085405
        for <linux-integrity@vger.kernel.org>; Thu, 2 May 2019 12:53:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s83p7acxf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 May 2019 12:53:21 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 2 May 2019 17:53:19 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 17:53:02 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42Gr19Y45023262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 16:53:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3AD5611C04A;
        Thu,  2 May 2019 16:53:01 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18D0111C050;
        Thu,  2 May 2019 16:53:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.175])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 16:52:59 +0000 (GMT)
Subject: Re: [PATCH v3 4/4] added LSM hook to call ima_buffer_check
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, vgoyal@redhat.com, nayna@linux.ibm.com
Date:   Thu, 02 May 2019 12:52:49 -0400
In-Reply-To: <20190429214743.4625-5-prsriva02@gmail.com>
References: <20190429214743.4625-1-prsriva02@gmail.com>
         <20190429214743.4625-5-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050216-0028-0000-0000-00000369A3B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050216-0029-0000-0000-000024290FE7
Message-Id: <1556815969.4134.79.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020109
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-04-29 at 14:47 -0700, Prakhar Srivastava wrote:
> From: Prakhar Srivastava <prsriva02@gmail.com>
> 
> added LSM hook to call ima_buffer_check

Casey just responded, "I can imagine an LSM that cares about the
command line, but I don't have interest in it for any work I have in
progress."  Unless one of the other LSM maintainers is interested,
let's leave it as an IMA only hook.

Mimi

> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> ---
>  include/linux/lsm_hooks.h | 3 +++
>  include/linux/security.h  | 3 +++
>  kernel/kexec_internal.h   | 4 +++-
>  security/security.c       | 6 ++++++
>  4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index a240a3fc5fc4..f18562c1eb24 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1672,6 +1672,8 @@ union security_list_options {
>  	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
>  	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
>  
> +	int (*buffer_check)(const void *buff, int size, const char *eventname);
> +
>  #ifdef CONFIG_SECURITY_NETWORK
>  	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
>  					struct sock *newsk);
> @@ -1945,6 +1947,7 @@ struct security_hook_heads {
>  	struct hlist_head inode_notifysecctx;
>  	struct hlist_head inode_setsecctx;
>  	struct hlist_head inode_getsecctx;
> +	struct hlist_head buffer_check;
>  #ifdef CONFIG_SECURITY_NETWORK
>  	struct hlist_head unix_stream_connect;
>  	struct hlist_head unix_may_send;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 49f2685324b0..8dece6da0dda 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -388,6 +388,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
>  int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
> +void security_buffer_measure(const void *buff, int size, char *eventname);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_lsm_notifier(enum lsm_event event, void *data)
> @@ -1188,6 +1189,8 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
>  {
>  	return -EOPNOTSUPP;
>  }
> +static inline void security_buffer_measure(const void *buff, int size, char *eventname)
> +{ }
>  #endif	/* CONFIG_SECURITY */
>  
>  #ifdef CONFIG_SECURITY_NETWORK
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 48aaf2ac0d0d..9f967fbb5aa0 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -12,7 +12,9 @@ int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
>  void kimage_terminate(struct kimage *image);
>  int kimage_is_destination_range(struct kimage *image,
>  				unsigned long start, unsigned long end);
> -
> +int kexec_cmdline_prepend_img_name(char **outbuf, int kernel_fd,
> +				const char *cmdline_ptr,
> +				unsigned long cmdline_len);
>  extern struct mutex kexec_mutex;
>  
>  #ifdef CONFIG_KEXEC_FILE
> diff --git a/security/security.c b/security/security.c
> index 23cbb1a295a3..2b575a40470e 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -754,6 +754,12 @@ int security_bprm_check(struct linux_binprm *bprm)
>  	return ima_bprm_check(bprm);
>  }
>  
> +void security_buffer_measure(const void *buff, int size, char *eventname)
> +{
> +	call_void_hook(buffer_check, buff, size, eventname);
> +	return ima_buffer_check(buff, size, eventname);
> +}
> +
>  void security_bprm_committing_creds(struct linux_binprm *bprm)
>  {
>  	call_void_hook(bprm_committing_creds, bprm);

