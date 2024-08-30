Return-Path: <linux-integrity+bounces-3435-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799BB966559
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3651A285474
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2024 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5291B5817;
	Fri, 30 Aug 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCEgQ6TD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CEE1B532C;
	Fri, 30 Aug 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031581; cv=none; b=s+D0RMa9Jvv1kTSGibLn1grojvaSuHuJeNhBK5iWfbAderNyI9lTpmS5a354GmHeMJSiEcAq0xCsuTGtuv7LFOnCN5E9rdZuUw3ouTCthUQhlsTEd9rGpI3XbCbs3aUDFkN8EpS4FDvPpCLwRddiZtk/6D39hbrnUzK7oaE/9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031581; c=relaxed/simple;
	bh=T037Od0spN/0ZYY99Fg4NH/t4Tg40xcEOa6cRb4CP7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWaU+ATwP7KbiLE/WLbUr+Fpr7bZb9WW/DPjWy+kEqbapl8enna3D/pEhQrEGq/HFcqtCLS6y8m8LOL4AtcIyUAjZuO28Ey/OgzD7S5Q5N81vRRyvQaONzpAawnRVdnaMJsXgA5VvGfxgFfhtVItZlLFl6iNdWeh4viLkVspYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCEgQ6TD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725031580; x=1756567580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T037Od0spN/0ZYY99Fg4NH/t4Tg40xcEOa6cRb4CP7g=;
  b=jCEgQ6TD7JGYsNL7x/2i/BEh+dzsP5XWLVFge2JyFMQpjIXWrV6gIsm6
   Su2AZO+jvmlIg9k+Wu2yZBi4HkGU12FSSl3DG910QfamzceGKQUpvsAyl
   ppA2plp8VX1/wjpqkB+e+n3w2HFzbdKHX/PjMYgThvUan20/sLM08kgZI
   BsQ2IdFa/p2tIKeZyzdPyCqcnJRPgNaDmapEQCc3u4O9YTHaflm5Xd3gO
   onqOy7Gv8kA6e582xKb3Om3Rs7MbuFmJyE7yGJNOpnEzQJrtJRqOWgoYu
   2hSvf9nQaoLmF+irGAncY+PGUCUxX0Bjqx1e8DFtSW7P8iDX2WscI/iLo
   A==;
X-CSE-ConnectionGUID: /sETmdrlSKyHMM6BOY9u/g==
X-CSE-MsgGUID: 42Ba5SoQT0235y42e9Y4kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13299629"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="13299629"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 08:26:19 -0700
X-CSE-ConnectionGUID: rZo0LTKGQ1aj+EW3VbhPOg==
X-CSE-MsgGUID: VhDjiI7fS7aBxYr7ydxr6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63941615"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Aug 2024 08:26:15 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk3Vt-0001a8-1H;
	Fri, 30 Aug 2024 15:26:13 +0000
Date: Fri, 30 Aug 2024 23:26:11 +0800
From: kernel test robot <lkp@intel.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
	linux-security-module@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jmorris@namei.org, serge@hallyn.com,
	keescook@chromium.org, john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	mic@digikod.net, linux-integrity@vger.kernel.org,
	audit@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH v2 10/13] LSM: Create new security_cred_getlsmblob LSM
 hook
Message-ID: <202408302310.YKuNPXRT-lkp@intel.com>
References: <20240830003411.16818-11-casey@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830003411.16818-11-casey@schaufler-ca.com>

Hi Casey,

kernel test robot noticed the following build errors:

[auto build test ERROR on pcmoore-audit/next]
[also build test ERROR on pcmoore-selinux/next zohar-integrity/next-integrity linus/master v6.11-rc5 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/LSM-Add-the-lsmblob-data-structure/20240830-085050
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
patch link:    https://lore.kernel.org/r/20240830003411.16818-11-casey%40schaufler-ca.com
patch subject: [PATCH v2 10/13] LSM: Create new security_cred_getlsmblob LSM hook
config: microblaze-allnoconfig (https://download.01.org/0day-ci/archive/20240830/202408302310.YKuNPXRT-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240830/202408302310.YKuNPXRT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408302310.YKuNPXRT-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/net/scm.h:9,
                    from include/linux/netlink.h:9,
                    from lib/kobject_uevent.c:24:
   include/linux/security.h: In function 'security_cred_getlsmblob':
>> include/linux/security.h:1199:10: error: 'secid' undeclared (first use in this function)
    1199 |         *secid = 0;
         |          ^~~~~
   include/linux/security.h:1199:10: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from include/net/scm.h:9,
                    from include/linux/netlink.h:9,
                    from include/uapi/linux/neighbour.h:6,
                    from include/linux/netdevice.h:45,
                    from include/net/sock.h:46,
                    from include/linux/tcp.h:19,
                    from include/linux/ipv6.h:101,
                    from include/net/addrconf.h:61,
                    from lib/vsprintf.c:41:
   include/linux/security.h: In function 'security_cred_getlsmblob':
>> include/linux/security.h:1199:10: error: 'secid' undeclared (first use in this function)
    1199 |         *secid = 0;
         |          ^~~~~
   include/linux/security.h:1199:10: note: each undeclared identifier is reported only once for each function it appears in
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1683:9: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1683 |         buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
         |         ^~~


vim +/secid +1199 include/linux/security.h

  1195	
  1196	static inline void security_cred_getlsmblob(const struct cred *c,
  1197						    struct lsmblob *blob)
  1198	{
> 1199		*secid = 0;
  1200	}
  1201	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

